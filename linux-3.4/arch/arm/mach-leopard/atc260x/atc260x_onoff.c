/*
 * atc260x_onoff.c  --  On/Off key driver for ATC260X
 *
 * Copyright 2011 Actions Semi Inc.
 * Author: Actions Semi, Inc.
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/input.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/workqueue.h>
#include <linux/delay.h>

//#include <asm/mach-actions/atc260x.h>
//#include <asm/mach-actions/atv5201/atv5201_def.h>
//#include <asm/mach-actions/atc260x_pdata.h>
//#include "atc260x_dev.h"
#include <mach/atc260x/atc260x.h>
#include <mach/atc260x/atc260x_pdata.h>
#include <mach/atc260x/atc260x_dev.h>

/* register bits in PMU_SYS_CTL2 */
#define ONOFF_RESET_TIME_SEL(x)         (((x) & 0x3) << 7)
#define ONOFF_RESET_EN                  (1 << 9)
#define ONOFF_PRESS_TIME(x)             (((x) & 0x3) << 10)
#define ONOFF_INT_EN                    (1 << 12)
#define ONOFF_LONG_PRESS                (1 << 13)
#define ONOFF_SHORT_PRESS               (1 << 14)
#define ONOFF_PRESS                     (1 << 15)

//extern int get_config(const char *key, char *buff, int len);
extern int asoc_pm_wakeup_flag(void);

int register_power_press(int (*func)(void));
int unregister_power_press(int (*func)(void));
int power_long = 0;

static struct atc260x_dev *atc260x_global = NULL;
/* On/Off module structure */
struct atc260x_onoff {
    struct input_dev *dev;
    struct delayed_work work;
    struct atc260x_dev *atc260x;
    int irq;
};

/**
 * The chip gives us an interrupt when the ON/OFF pin is asserted but we
 * then need to poll to see when the pin is deasserted.
 */
static void atc260x_poll_onoff(struct work_struct *work)
{
    struct atc260x_onoff *atc260x_onoff = container_of(work, struct atc260x_onoff,
                           work.work);
    struct atc260x_dev *atc260x = atc260x_onoff->atc260x;
    int poll, ret;

    ret = atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL2);   
    if (ret >= 0) {
        poll = ret & (ONOFF_SHORT_PRESS | ONOFF_PRESS);

        printk(KERN_DEBUG "[ATC260X] On/Off key CTL2 = %x, poll = %d\n", ret, poll);

        /* cleare On/Off press pending */
        atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL2, 
            ONOFF_SHORT_PRESS | ONOFF_LONG_PRESS, 
            ONOFF_SHORT_PRESS | ONOFF_LONG_PRESS);

        /* report key pressed */
        input_report_key(atc260x_onoff->dev, KEY_POWER, poll);
        input_sync(atc260x_onoff->dev);
    } else {
        dev_err(atc260x->dev, "Failed to read ON/OFF status: %d\n", ret);
        poll = 1;
    }

    /* if key is pressed, check key status after 200 ms */
    if (poll) {
        schedule_delayed_work(&atc260x_onoff->work, msecs_to_jiffies(200));
    } else {
        /* enable the On/Off IRQ */
        atc260x_set_bits(atc260x_onoff->atc260x, atc2603_PMU_SYS_CTL2, 
            ONOFF_INT_EN, ONOFF_INT_EN);
    }
}

/**
 * On/Off IRQ hander, run in kernel thread of ATC260X core IRQ dispatcher 
 */
static irqreturn_t atc260x_onoff_irq(int irq, void *data)
{
    struct atc260x_onoff *atc260x_onoff = data;

    /* disable On/Off interrupt, but not clear the On/Off IRQ pending */
    atc260x_set_bits(atc260x_onoff->atc260x, atc2603_PMU_SYS_CTL2, 
        ONOFF_INT_EN | ONOFF_SHORT_PRESS | ONOFF_LONG_PRESS, 0);
    
    schedule_delayed_work(&atc260x_onoff->work, 0);

    return IRQ_HANDLED;
}

static pm_message_t pm_state;

static int atc260x_onoff_suspend(struct platform_device *pdev, pm_message_t m)
{
	  struct atc260x_dev *atc260x = dev_get_drvdata(pdev->dev.parent);
     struct atc260x_onoff *atc260x_onoff = platform_get_drvdata(pdev);
    dev_info(&pdev->dev, "atc260x_onoff_suspend()\n");
    pm_state = m;
    
    
    /* disable On/Off interrupt, but not clear the On/Off IRQ pending */
    atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL2, 
        ONOFF_INT_EN | ONOFF_SHORT_PRESS | ONOFF_LONG_PRESS, 0);
    
    cancel_delayed_work_sync(&atc260x_onoff->work);
    
    return 0;
}

static int atc260x_onoff_resume(struct platform_device *pdev)
{
    struct atc260x_onoff *atc260x_onoff = platform_get_drvdata(pdev);
	int wakeup_flag;
	
    printk(KERN_DEBUG "atc260x_onoff_resume()\n");

    if(pm_state.event == PM_EVENT_FREEZE) {
        struct atc260x_dev *atc260x = dev_get_drvdata(pdev->dev.parent);
        atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL2, ONOFF_INT_EN | ONOFF_PRESS_TIME(3), ONOFF_INT_EN | ONOFF_PRESS_TIME(0));
    }
    else {
          	struct atc260x_dev *atc260x = dev_get_drvdata(pdev->dev.parent);	
    	      atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL2, ONOFF_INT_EN | ONOFF_PRESS_TIME(3), ONOFF_INT_EN | ONOFF_PRESS_TIME(0));

        wakeup_flag = asoc_pm_wakeup_flag();
//        if (wakeup_flag == WAKEUP_SRC_ONOFF_SHORT ||
//             wakeup_flag == WAKEUP_SRC_ONOFF_LONG ||
//             wakeup_flag == WAKEUP_SRC_WALL_IN ||
//             wakeup_flag == WAKEUP_SRC_VBUS_IN) 
	if(( (wakeup_flag & WAKEUP_SRC_ONOFF_SHORT) != 0)
	    || ((wakeup_flag & WAKEUP_SRC_ONOFF_LONG) != 0)
		|| ((wakeup_flag & WAKEUP_SRC_WALL_IN) != 0 )
		|| ((wakeup_flag & WAKEUP_SRC_VBUS_IN) != 0))
	{
    
            printk(KERN_DEBUG "wakeup by On/Off key!\n");
    
            input_report_key(atc260x_onoff->dev, KEY_POWER, 1);
            input_report_key(atc260x_onoff->dev, KEY_POWER, 0);
    
            input_sync(atc260x_onoff->dev);
        }

    }
    
    schedule_delayed_work(&atc260x_onoff->work, 0);


#if 0
    /* FIXME: report key pressed for wakelock anyway */
    input_report_key(atc260x_onoff->dev, KEY_POWER, 1);
    input_report_key(atc260x_onoff->dev, KEY_POWER, 0);
    input_sync(atc260x_onoff->dev);
#endif

    return 0;
}

static int atc260x_onoff_shutdown(struct platform_device *pdev)
{
    struct atc260x_dev *atc260x = dev_get_drvdata(pdev->dev.parent);
    struct atc260x_onoff *atc260x_onoff = platform_get_drvdata(pdev);

    dev_info(&pdev->dev, "atc260x_onoff_shutdown()\n");

    /* disable On/Off interrupt, but not clear the On/Off IRQ pending */
    atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL2, 
        ONOFF_PRESS_TIME(3), ONOFF_PRESS_TIME(2));

    return 0;
}


static int __devinit atc260x_onoff_probe(struct platform_device *pdev)
{
    struct atc260x_dev *atc260x = dev_get_drvdata(pdev->dev.parent);
    struct atc260x_onoff *atc260x_onoff;
    int onoff_time = 0;
    int irq = platform_get_irq(pdev, 0);
    int ret;

    printk("[ATC260X] probe On/Off key\n");

    if (irq < 0) {
        dev_err(&pdev->dev, "No IRQ resource for On/Off key\n");
    }
    
    atc260x_onoff = kzalloc(sizeof(struct atc260x_onoff), GFP_KERNEL);
    if (!atc260x_onoff) {
        dev_err(&pdev->dev, "Can't allocate data\n");
        return -ENOMEM;
    }

    atc260x_onoff->atc260x = atc260x;
    atc260x_global = atc260x;
    INIT_DELAYED_WORK(&atc260x_onoff->work, atc260x_poll_onoff);

    atc260x_onoff->dev = input_allocate_device();
    if (!atc260x_onoff->dev) {
        dev_err(&pdev->dev, "Can't allocate input dev\n");
        ret = -ENOMEM;
        goto err;
    }

    atc260x_onoff->dev->evbit[0] = BIT_MASK(EV_KEY);
    atc260x_onoff->dev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
    atc260x_onoff->dev->name = "atc260x_onoff";
    atc260x_onoff->dev->phys = "atc260x_onoff/input0";
    atc260x_onoff->dev->dev.parent = &pdev->dev;

    /* 
     *use default primary handle, and atc260x_onoff_irq run in ATC260X core irq kernel thread 
     */
    ret = request_threaded_irq(irq, NULL, atc260x_onoff_irq,
                   IRQF_TRIGGER_HIGH, "atc260x_onoff",
                   atc260x_onoff);
    if (ret < 0) {
        dev_err(&pdev->dev, "Unable to request IRQ: %d\n", ret);
        goto err_input_dev;
    }

    atc260x_onoff->irq = irq;   

    ret = input_register_device(atc260x_onoff->dev);
    if (ret) {
        dev_dbg(&pdev->dev, "Can't register input device: %d\n", ret);
        goto err_irq;
    }

    platform_set_drvdata(pdev, atc260x_onoff);

    /* enable On/Off key interrupt */
//    if(get_config("onoff.time",(char *)&onoff_time,4)!=0){
//			onoff_time = 2;
//		}

//    onoff_time = 2; /*for debug by jlingzhang*/
    onoff_time = 0; /* more quick response of the on/off key */

    ret = atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL2, ONOFF_INT_EN | ONOFF_PRESS_TIME(3), ONOFF_INT_EN | ONOFF_PRESS_TIME(onoff_time));
     
    return 0;

err_irq:
    free_irq(irq, atc260x_onoff);
err_input_dev:
    input_free_device(atc260x_onoff->dev);
err:
    kfree(atc260x_onoff);
    return ret;
}

static int __devexit atc260x_onoff_remove(struct platform_device *pdev)
{
    struct atc260x_onoff *atc260x_onoff = platform_get_drvdata(pdev);
    int irq = platform_get_irq(pdev, 0);

    free_irq(irq, atc260x_onoff);
    cancel_delayed_work_sync(&atc260x_onoff->work);
    input_unregister_device(atc260x_onoff->dev);
    kfree(atc260x_onoff);

    return 0;
}

static struct platform_driver atc260x_onoff_driver = {
    .probe      = atc260x_onoff_probe,
    .remove     = __devexit_p(atc260x_onoff_remove),
    .driver     = {
        .name   = "atc260x-onoff",
        .owner  = THIS_MODULE,
    },
    .suspend     = atc260x_onoff_suspend,
    .resume     = atc260x_onoff_resume,
    .shutdown   = atc260x_onoff_shutdown,
};

static int atc260x_poll_power_long(void)
{
    unsigned short tmp ;
    if(power_long == 0)
    {
        /**/
        tmp = atc260x_reg_read(atc260x_global, atc2603_PMU_SYS_CTL2);
        if((tmp & ONOFF_PRESS) != 0)
        {
            power_long = 1;
        }
    }
    return power_long;
}

static int __init atc260x_onoff_init(void)
{
    register_power_press(atc260x_poll_power_long);
    return platform_driver_register(&atc260x_onoff_driver);
}
module_init(atc260x_onoff_init);

static void __exit atc260x_onoff_exit(void)
{
    unregister_power_press(atc260x_poll_power_long);
    platform_driver_unregister(&atc260x_onoff_driver);
}
module_exit(atc260x_onoff_exit);

MODULE_ALIAS("platform:atc260x-onff");
MODULE_DESCRIPTION("ATC260X ON/OFF pin");
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Actions Semi, Inc");