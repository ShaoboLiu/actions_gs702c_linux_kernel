#include <linux/err.h>
#include <linux/module.h>
#include <linux/ion.h>
#include <linux/asoc_ion.h>
#include <linux/platform_device.h>
#include <linux/slab.h>
#include <linux/uaccess.h>
#include "../ion_priv.h"

struct ion_mapper *asoc_user_mapper;
int num_heaps;
struct ion_heap **heaps;

struct ion_device *asoc_ion_device;
EXPORT_SYMBOL(asoc_ion_device);

static int asoc_ion_get_phys(struct ion_client *client,
					unsigned int cmd,
					unsigned long arg)
{
#if 0
	bool valid_handle;
#endif
	struct asoc_ion_phys_data data;
	struct asoc_ion_phys_data *user_data =
				(struct asoc_ion_phys_data *)arg;
	struct ion_buffer *buffer;
	int ret;

	if (copy_from_user(&data, (void __user *)arg, sizeof(data)))
		return -EFAULT;

#if 0
	mutex_lock(&client->lock);
	valid_handle = ion_handle_validate(client, data.handle);
	mutex_unlock(&client->lock);

	if (!valid_handle) {
		WARN(1, "%s: invalid handle passed to get id.\n", __func__);
		return -EINVAL;
	}
#endif

	buffer = ion_handle_buffer(data.handle);
	ret = ion_phys(client, data.handle, &data.phys_addr, &data.size);
	if(ret < 0)
		return ret;

	if (copy_to_user(user_data, &data, sizeof(data)))
		return -EFAULT;

	return 0;
}

static long asoc_ion_ioctl(struct ion_client *client,
				   unsigned int cmd,
				   unsigned long arg)
{
	int ret = -EINVAL;

	switch (cmd) {
	case ASOC_ION_GET_PHY:
		ret = asoc_ion_get_phys(client, cmd, arg);
		break;
	default:
		WARN(1, "Unknown custom ioctl\n");
		return -EINVAL;
	}
	return ret;
}

int asoc_ion_probe(struct platform_device *pdev)
{
	struct ion_platform_data *pdata = pdev->dev.platform_data;
	int err;
	int i;

#ifdef CONFIG_CMA
	set_cma_dev(&(pdev->dev));
#endif
 	ION_PRINT("%s()\n", __func__);

	num_heaps = pdata->nr;

	heaps = kzalloc(sizeof(struct ion_heap *) * pdata->nr, GFP_KERNEL);

	asoc_ion_device = ion_device_create(asoc_ion_ioctl);
	if (IS_ERR_OR_NULL(asoc_ion_device)) {
		kfree(heaps);
		return PTR_ERR(asoc_ion_device);
	}

	/* create the heaps as specified in the board file */
	for (i = 0; i < num_heaps; i++) {
		struct ion_platform_heap *heap_data = &pdata->heaps[i];

		heaps[i] = ion_heap_create(heap_data);
		if (IS_ERR_OR_NULL(heaps[i])) {
			err = PTR_ERR(heaps[i]);
			goto err;
		}
		ion_device_add_heap(asoc_ion_device, heaps[i]);
	}
	platform_set_drvdata(pdev, asoc_ion_device);
	return 0;
err:
	for (i = 0; i < num_heaps; i++) {
		if (heaps[i])
			ion_heap_destroy(heaps[i]);
	}
	kfree(heaps);
	return err;
}

int asoc_ion_remove(struct platform_device *pdev)
{
	struct ion_device *asoc_ion_device = platform_get_drvdata(pdev);
	int i;

	ion_device_destroy(asoc_ion_device);
	for (i = 0; i < num_heaps; i++)
		ion_heap_destroy(heaps[i]);
	kfree(heaps);
	return 0;
}

static struct platform_driver ion_driver = {
	.probe = asoc_ion_probe,
	.remove = asoc_ion_remove,
	.driver = { .name = "ion-asoc" }
};

static int __init ion_init(void)
{
	return platform_driver_register(&ion_driver);
}

static void __exit ion_exit(void)
{
	platform_driver_unregister(&ion_driver);
}

module_init(ion_init);
module_exit(ion_exit);
