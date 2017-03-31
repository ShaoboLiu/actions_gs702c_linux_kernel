/*
 * atc260x_core.c  --  Device access for Actions ATC260X PMIC
 *
 * Copyright 2009 Actions Semi Inc.
 * Author: Actions Semi, Inc.
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of  the GNU General  Public License as published by the
 *  Free Software Foundation;  either version 2 of the  License, or (at your
 *  option) any later version.
 *
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/bcd.h>
#include <linux/delay.h>
#include <linux/mfd/core.h>
#include <linux/slab.h>
#include <linux/suspend.h>

#include <mach/atc260x/atc260x.h>
#include <mach/atc260x/atc260x_pdata.h>
#include <mach/atc260x/atc260x_dev.h>

#define CONFIG_ATC260X_REGISTER_ACCESS_DIRECT
/* export register read/write interface to device sysfs */
#define CONFIG_ATC260X_SYSFS_REG

//#undef dev_dbg
//#define dev_dbg(fmt...) do{}while(0)

/* CMU_DEVRST bit */
#define TP_CLK_EN               (1 << 8)
#define ETHERNET_CLK_EN         (1 << 9)
#define AUDIO_CLK_EN            (1 << 10)

/*
 * global atc260x device handle, for internal used only
 */
struct atc260x_dev *atc260x_dev_handle = NULL;

EXPORT_SYMBOL_GPL(atc260x_dev_handle);

extern int (* boot_info_read)(unsigned short reg);
extern int (* boot_info_write)(unsigned short reg, unsigned short val);

static int atc260x_read(struct atc260x_dev *atc260x, unsigned short reg,
               int bytes, void *dest)
{
    int ret, i;
    u16 *buf = dest;

    BUG_ON(bytes % 2);
    BUG_ON(bytes <= 0);

    ret = atc260x->read_dev(atc260x, reg, bytes, dest);
    if (ret < 0)
        return ret;

    for (i = 0; i < bytes / 2; i++) {
        dev_vdbg(atc260x->dev, "Read %04x from R%d(0x%x)\n",
             buf[i], reg + i, reg + i);
    }

    return 0;
}

/**
 * atc260x_reg_read: Read a single ATC260X register.
 *
 * @atc260x: Device to read from.
 * @reg: Register to read.
 */
int atc260x_reg_read(struct atc260x_dev *atc260x, unsigned short reg)
{
    unsigned short val;
    int ret;

    mutex_lock(&atc260x->io_lock);

    ret = atc260x_read(atc260x, reg, 2, &val);

    dev_dbg(atc260x->dev, "%s(reg:0x%04x): 0x%04x\n", __FUNCTION__, reg, val);

    mutex_unlock(&atc260x->io_lock);

    if (ret < 0)
        return ret;
    else
        return val;
}
EXPORT_SYMBOL_GPL(atc260x_reg_read);

/**
 * atc260x_boot_info_read: Read a single ATC260X register for kernel restart.
 *
 * @reg: Register to read.
 */
int atc260x_boot_info_read(unsigned short reg)
{
    return atc260x_reg_read(atc260x_dev_handle, reg);
}

static int atc260x_write(struct atc260x_dev *atc260x, unsigned short reg,
            int bytes, void *src)
{
    u16 *buf = src;
    int i;

    BUG_ON(bytes % 2);
    BUG_ON(bytes <= 0);

    for (i = 0; i < bytes / 2; i++) {
        dev_vdbg(atc260x->dev, "Write %04x to R%d(0x%x)\n",
             buf[i], reg + i, reg + i);
    }

    return atc260x->write_dev(atc260x, reg, bytes, src);
}

/**
 * atc260x_reg_write: Write a single ATC260X register.
 *
 * @atc260x: Device to write to.
 * @reg: Register to write to.
 * @val: Value to write.
 */
int atc260x_reg_write(struct atc260x_dev *atc260x, unsigned short reg,
             unsigned short val)
{
    int ret;

    mutex_lock(&atc260x->io_lock);

    dev_dbg(atc260x->dev, "%s(reg:0x%04x, val:0x%04x)\n", __FUNCTION__, reg, val);

    ret = atc260x_write(atc260x, reg, 2, &val);

    mutex_unlock(&atc260x->io_lock);

    return ret;
}
EXPORT_SYMBOL_GPL(atc260x_reg_write);

/**
 * atc260x_boot_info_write: Write a single ATC260X register for kernel restart.
 *
 * @reg: Register to write to.
 * @val: Value to write.
 */
int atc260x_boot_info_write(unsigned short reg, unsigned short val)
{
    return atc260x_reg_write(atc260x_dev_handle, reg, val);
}

/**
 * atc260x_set_bits: Set the value of a bitfield in a ATC260X register
 *
 * @atc260x: Device to write to.
 * @reg: Register to write to.
 * @mask: Mask of bits to set.
 * @val: Value to set (unshifted)
 */
int atc260x_set_bits(struct atc260x_dev *atc260x, unsigned short reg,
            unsigned short mask, unsigned short val)
{
    int ret;
    u16 r;

    mutex_lock(&atc260x->io_lock);

    dev_dbg(atc260x->dev, "%s(reg:0x%04x, mask:0x%04x, val:0x%04x)\n", 
        __FUNCTION__, reg, mask, val);

    ret = atc260x_read(atc260x, reg, 2, &r);
    if (ret < 0)
        goto out;

    r &= ~mask;
    r |= val;

    ret = atc260x_write(atc260x, reg, 2, &r);

out:
    mutex_unlock(&atc260x->io_lock);

    return ret;
}
EXPORT_SYMBOL_GPL(atc260x_set_bits);

int atc260x_set_access_mode(struct atc260x_dev *atc260x, int mode)
{
    if (atc260x && atc260x->set_access_mode)
        return atc260x->set_access_mode(atc260x, mode);
    
    return -EINVAL;
}
EXPORT_SYMBOL_GPL(atc260x_set_access_mode);

/**
 * atc260x_cmu_reset: Reset a ATC260X CMU module.
 *
 * @atc260x: Device to read from.
 * @cmu_module: cmu module to reset.
 */
int atc260x_cmu_reset(struct atc260x_dev *atc260x, int cmu_module)
{
    int ret;

    if (cmu_module >= ATC260X_CMU_MODULE_NUM) {
        dev_err(atc260x->dev, "Invalid ATC260X cmu module: %d\n", cmu_module);
        return -EINVAL;
    }

    ret = atc260x_set_bits(atc260x, atc2603_CMU_DEVRST, 1 << cmu_module, 0 << cmu_module);
    if (ret < 0) {
        return ret;
    }

    ret = atc260x_set_bits(atc260x, atc2603_CMU_DEVRST, 1 << cmu_module, 1 << cmu_module);
    if (ret < 0) {
        return ret;
    }
    
    return 0;
}
EXPORT_SYMBOL_GPL(atc260x_cmu_reset);

static int cmu_module_to_clk_bit(int cmu_module)
{
    int bit;
    
    switch (cmu_module) {
        case 0:
            bit = TP_CLK_EN;
            break;
        case 3:
            bit = ETHERNET_CLK_EN;
            break;
        case 4:
            bit = AUDIO_CLK_EN;
            
        case 1:
        case 2:
        default:
            bit = -1;
        }
    
        return bit;
}

/**
 * atc260x_cmu_enable: Disable a ATC260X CMU module.
 *
 * @atc260x: Device to read from.
 * @cmu_module: cmu module to enable.
 */
int atc260x_cmu_enable(struct atc260x_dev *atc260x, int cmu_module)
{
    int ret, bit;

    if (cmu_module >= ATC260X_CMU_MODULE_NUM) {
        dev_err(atc260x->dev, "Invalid ATC260X cmu module: %d\n", cmu_module);
        return -EINVAL;
    }

    bit = cmu_module_to_clk_bit(cmu_module);
    if (bit < 0) {
        return 0;
    }
            
    ret = atc260x_set_bits(atc260x, atc2603_CMU_DEVRST, bit, bit);
    if (ret < 0) {
        return ret;
    }

    return 0;
}
EXPORT_SYMBOL_GPL(atc260x_cmu_enable);


/**
 * atc260x_cmu_disable: Disable a ATC260X CMU module.
 *
 * @atc260x: Device to read from.
 * @cmu_module: cmu module to disable.
 */
int atc260x_cmu_disable(struct atc260x_dev *atc260x, int cmu_module)
{
    int ret, bit;

    if (cmu_module >= ATC260X_CMU_MODULE_NUM) {
        dev_err(atc260x->dev, "Invalid ATC260X cmu module: %d\n", cmu_module);
        return -EINVAL;
    }

    bit = cmu_module_to_clk_bit(cmu_module);
    if (bit < 0) {
        return 0;
    }
            
    ret = atc260x_set_bits(atc260x, atc2603_CMU_DEVRST, bit, 0);
    if (ret < 0) {
        return ret;
    }

    return 0;
}
EXPORT_SYMBOL_GPL(atc260x_cmu_disable);

/* auxadc id -> auxadc register */
static int auxadc_dat_reg[16] = {
    atc2603_PMU_IREFADC,     atc2603_PMU_CHGIADC,
    atc2603_PMU_VBUSIADC,    atc2603_PMU_WALLIADC,
    atc2603_PMU_BATIADC,     atc2603_PMU_RemConADC,
    atc2603_PMU_ICTEMPADC,   atc2603_PMU_BATVADC,
    atc2603_PMU_BAKBATADC,   atc2603_PMU_SYSPWRADC,
    atc2603_PMU_WALLVADC,    atc2603_PMU_VBUSVADC,
    atc2603_PMU_AuxADC3,     atc2603_PMU_AuxADC2,
    atc2603_PMU_AuxADC1,     atc2603_PMU_AuxADC0,     
};

/**
 * atc260x_auxadc_read: Read a value from the ATC260X AUXADC
 *
 * @atc260x: Device to read from.
 * @input: AUXADC input to read.
 */
int atc260x_auxadc_reg_read(struct atc260x_dev *atc260x, enum atc260x_auxadc input)
{
    int ret, src;

    mutex_lock(&atc260x->auxadc_lock);

    if (input > 15) {
        ret = -EINVAL;
        goto out;       
    }
    
    /* We force a single source at present */
    src = input;

    ret = atc260x_reg_read(atc260x, atc2603_PMU_AuxADC_CTL0);
    if (ret < 0) {
        dev_err(atc260x->dev, "Failed to read AUXADC source: %d\n", ret);
        goto out;
    }

    /* if current status is disabled, enable it and wait 1ms for translate. */
    if ((ret & (1 << src)) == 0)
    {
        ret = atc260x_reg_write(atc260x, atc2603_PMU_AuxADC_CTL0,
                       1 << src);
        if (ret < 0) {
            dev_err(atc260x->dev, "Failed to set AUXADC source: %d\n", ret);
            goto out;
        }

        msleep(1);
    }

    ret = atc260x_reg_read(atc260x,
                  auxadc_dat_reg[src]);
    if (ret < 0) {
        dev_err(atc260x->dev,
            "Failed to read AUXADC data: %d\n", ret);
        goto out;
    }

    dev_dbg(atc260x->dev, "%s(input:%d): %d\n", __FUNCTION__, input, ret);

out:
    mutex_unlock(&atc260x->auxadc_lock);
    return ret;
}
EXPORT_SYMBOL_GPL(atc260x_auxadc_reg_read);


/**
 * atc260x_auxadc_read: Read voltage/current value from the ATC260X AUXADC
 *
 * @atc260x: Device to read from.
 * @input: AUXADC input to read.
 */
int atc260x_auxadc_read(struct atc260x_dev *atc260x, enum atc260x_auxadc input)
{
    int ret;

    ret = atc260x_auxadc_reg_read(atc260x, input);
    if (ret < 0)
        return ret;

    switch (input) {
    case ATC260X_AUX_WALLV:
    case ATC260X_AUX_VBUSV:
    case ATC260X_AUX_SYSPWRV:
        ret *= 2930;                        /* 2.93mv * 2.5 */      
        ret = ret * 2 + ret / 2;
        ret /= 1000;                        /* uV -> mV */
        break;      
    case ATC260X_AUX_BATV:
        ret *= 2930 * 2;                    /* 2.93mv * 2 */
        ret /= 1000;                        /* uV -> mV */      
        break;

    case ATC260X_AUX_WALLI:
    case ATC260X_AUX_VBUSI:
    case ATC260X_AUX_BATI:
    case ATC260X_AUX_CHGI:
        ret = (ret * 1500 / 1024);          /* mA */
        break;          
    case ATC260X_AUX_REMCON:
        ret = ret / 1024;                   /* Remcon / SVCC */
        break;
    case ATC260X_AUX_TEMP:
        ret = (ret * 195) - 14899;          /* (mC) */
        break;      
    default:
        break;
    }

    dev_dbg(atc260x->dev, "%s(input:%d): %d\n", __FUNCTION__, input, ret);
    
    return ret;
}
EXPORT_SYMBOL_GPL(atc260x_auxadc_read);


/*
 * get chip version of atc260x
 */
int atc260x_get_version()
{
    int ret, val=0;

    if (atc260x_dev_handle == NULL)
        return -ENODEV;

    ret = atc260x_reg_read(atc260x_dev_handle, atc2603_CVER);
    if (ret < 0) {
        dev_err(atc260x_dev_handle->dev,
            "Failed to read version data: %d\n", ret);
        return ret;
    }

    printk("\n %s val:%d", __FUNCTION__, (ret&0x7));
    switch(ret & 0x7)
    {
    case 0:
        return 0;
    case 1:
        return 1;
    case 3:
        return 2;
    case 7:
        return 3;
    default:
       return (ret & 0x7);
    }
   return -ENODEV; 
}
EXPORT_SYMBOL_GPL(atc260x_get_version);

#ifdef CONFIG_ATC260X_SYSFS_REG
/*
 * read or write a atc260x register from sysfs
 *
 * example:
 *   read reg 0x101: echo 0x101 > /sys/...
 *   write 0x55aa to reg 0x101: echo 0x101=0x55aa > /sys/...
 *
 * note: only used for debug
 */
static ssize_t store_atc260x_reg(struct device *dev, struct device_attribute *attr,
                                 const char *buf, size_t count)
{
	unsigned int reg, read_val, reg_val;
	unsigned int ret;
    char *end_ptr;
    int write = 0;

    reg = simple_strtoul(buf, &end_ptr, 16);

	if ((buf == end_ptr) || (reg > 0xffff))
		goto out;

    if (*end_ptr++ == '=') {
        reg_val = simple_strtoul(end_ptr, NULL, 16);
        if(reg_val > 0xffff)
            goto out;

        write = 1;
    }

    read_val = atc260x_reg_read(atc260x_dev_handle, (unsigned short)reg);
    if (read_val < 0)
        goto out;

    pr_err("[ATC260x] reg [0x%04x]: 0x%04x\n", reg, read_val);

    if (write) {
        ret = atc260x_reg_write(atc260x_dev_handle, (unsigned short)reg,
            (unsigned short)reg_val);
        if (ret < 0)
            goto out;

        pr_err("[ATC260x] reg [0x%04x] <- 0x%04x\n", reg, reg_val);
    }

out:
	return count;
}

static ssize_t store_set_charger_status(struct device *dev, struct device_attribute *attr,
                                 const char *buf, size_t count)
{
    unsigned int status=0;
    unsigned short tmp = 0;
     char *end_ptr;
    status = simple_strtoul(buf, &end_ptr, 16);
    if ((buf == end_ptr) || (status > 0x1))
	{
	    printk("\n error at %s %d", __FUNCTION__, __LINE__);
	    goto out;
	}
	
	printk("\n %s status:0x%x", __FUNCTION__, status);
	if(status != 0)
	{
	    tmp = atc260x_reg_read(atc260x_dev_handle, (unsigned short)atc2603_PMU_UV_INT_EN);
	    tmp |= (0x1<<0);
	    atc260x_reg_write(atc260x_dev_handle, (unsigned short)atc2603_PMU_UV_INT_EN,
        (unsigned short)tmp);
	}
	
	printk("\n %s atc2603_PMU_UV_INT_EN:0x%x", __FUNCTION__,atc260x_reg_read(atc260x_dev_handle, (unsigned short)atc2603_PMU_UV_INT_EN));
		
out:
	return count;    
}

static ssize_t store_atc260x_bit_reg(struct device *dev, struct device_attribute *attr,
                                 const char *buf, size_t count)
{
	unsigned int reg, read_val, bit_val, tmp_value;
	unsigned int bit_offset;
	unsigned int ret;
    char *end_ptr;
    int write = 0;

    reg = simple_strtoul(buf, &end_ptr, 16);

	if ((buf == end_ptr) || (reg > 0xffff))
		goto out;

    if(*end_ptr++ == ':')
    {
        bit_offset = simple_strtoul(end_ptr, NULL, 16);
        if(bit_offset > 0xf)
        {
            goto out;
        }
    }
    
    if (*end_ptr++ == '=') {
        bit_val = simple_strtoul(end_ptr, NULL, 16);
        if(bit_val > 0x1)
            goto out;
    }

    read_val = atc260x_reg_read(atc260x_dev_handle, (unsigned short)reg);
    if (read_val < 0)
        goto out;

    printk("[ATC260x] reg [0x%04x]: 0x%04x, bit_offset:%d, bit_val:%d\n", reg, read_val, bit_offset, bit_val);
    
    if(bit_val == 1)
    {
          tmp_value = (read_val | (0x1<<bit_offset));
    }
    else
    {
         tmp_value = (read_val & (~(0x1<<bit_offset)));
    }
  
    ret = atc260x_reg_write(atc260x_dev_handle, (unsigned short)reg,
        (unsigned short)tmp_value);
    if (ret < 0)
        goto out;

    printk("[ATC260x] reg [0x%04x] <- 0x%04x\n", reg, tmp_value);
    
out:
	return count;
}

static ssize_t show_atc260x_reg(struct device *dev,
                                struct device_attribute *attr, char *buf)
{
    return sprintf(buf, "nothing to report\n");
}

static ssize_t show_atc260x_bit_reg(struct device *dev,
                                struct device_attribute *attr, char *buf)
{
    return sprintf(buf, "nothing to report\n");
}
static ssize_t show_set_charger_status(struct device *dev,
                                struct device_attribute *attr, char *buf)
{
    return sprintf(buf, "nothing to report\n");
}

static struct device_attribute atc260x_attrs[] = {
    __ATTR(atc260x_reg, 0644, show_atc260x_reg, store_atc260x_reg),
//    __ATTR(atc260x_bit_reg, 0644, show_atc260x_bit_reg, store_atc260x_bit_reg),
    __ATTR(set_charger_status, 0644, show_set_charger_status, store_set_charger_status),
};

/* create sysfs register operation interface */
static int atc260x_create_attr(struct device *dev)
{
    int i, ret;

    for (i = 0; i < ARRAY_SIZE(atc260x_attrs); i++) {
        ret = device_create_file(dev, &atc260x_attrs[i]);
        if (ret)
            return ret;
    }

    return 0;
}

static void atc260x_remove_attr(struct device *dev)
{
    int i;

    for (i = 0; i < ARRAY_SIZE(atc260x_attrs); i++) {    
        device_remove_file(dev, &atc260x_attrs[i]);
    }
}
#else /* CONFIG_ATC260X_SYSFS_REG */
static int atc260x_create_attr(struct device *dev)
{
    return 0;
}

static void atc260x_remove_attr(struct device *dev)
{
}
#endif /* CONFIG_ATC260X_SYSFS_REG */

static struct resource atc260x_onoff_resources[] = {
    {
        .start = ATC260X_IRQ_ONOFF,
        .end   = ATC260X_IRQ_ONOFF,
        .flags = IORESOURCE_IRQ,
    },
};

static struct resource atc260x_ethernet_resources[] = {
    {
        .start = ATC260X_IRQ_ETHERNET,
        .end   = ATC260X_IRQ_ETHERNET,
        .flags = IORESOURCE_IRQ,
    },
};

static struct resource atc260x_rtc_resources[] = {
    {
        .start = ATC260X_IRQ_ALARM,
        .end   = ATC260X_IRQ_ALARM,
        .flags = IORESOURCE_IRQ,
    },
};

static struct resource atc260x_tp_resources[] = {
    {
        .start = ATC260X_IRQ_TP,
        .end   = ATC260X_IRQ_TP,
        .flags = IORESOURCE_IRQ,
    },
};

static struct resource atc260x_audio_resources[] = {
    {
        .start = ATC260X_IRQ_AUDIO,
        .end   = ATC260X_IRQ_AUDIO,
        .flags = IORESOURCE_IRQ,
    },
};


static struct mfd_cell atc260x_devs[] = {
    /* Suspend / Wakeup */
    {
        .name = "atc260x-pm",
    },

    /* On/Off key */
    {
        .name = "atc260x-onoff",
        .num_resources = ARRAY_SIZE(atc260x_onoff_resources),
        .resources = atc260x_onoff_resources,
    },
    
      /* ethernet phy */
    {
        .name = "atc260x-ethernet",
        .num_resources = ARRAY_SIZE(atc260x_ethernet_resources),
        .resources = atc260x_ethernet_resources,
    },

    /* RTC */
    {
        .name = "atc260x-rtc",
        .num_resources = ARRAY_SIZE(atc260x_rtc_resources),
        .resources = atc260x_rtc_resources,
    },

    /* GPIO */
    {
        .name = "atc260x-gpio",
    },

    /* Touch pannel */
    {
        .name = "atc260x-tp",
        .num_resources = ARRAY_SIZE(atc260x_tp_resources),
        .resources = atc260x_tp_resources,
    },

    /* adckeypad */
    {
        .name = "atc260x-adckeypad",
    },

    /* rocker */
    {
        .name = "atc260x-rocker",
    },

    /* Audio */
    {
        .name = "atc260x-audio",
        .num_resources = ARRAY_SIZE(atc260x_audio_resources),
        .resources = atc260x_audio_resources,
    },

    /* Hardware monitor */
    {
        .name = "atc260x-hwmon",
    },

    /* Power */
    {
        .name = "atc260x-power",
    },

	/* Capacity gauge */
    {
        .name = "atc260x-cap-gauge",
    },

    /* Backup battery */
    {
        .name = "atc260x-backup",
    },

    /* DCDCs */
    {
        .name = "atc260x-buck",
        .id = 1,
    },
    {
        .name = "atc260x-buck",
        .id = 2,
    },
    {
        .name = "atc260x-buck",
        .id = 3,
    },

    /* 5v, for OTG & HDMI */
    {
        .name = "atc260x-boost",
        .id = 4,
    },

    /* Current SINK, for backlight */
    {
        .name = "atc260x-isink",
        .id = 5,
    },

    /* LDOs */
    {
        .name = "atc260x-ldo",
        .id = 1,
    },
    {
        .name = "atc260x-ldo",
        .id = 2,
    },
    {
        .name = "atc260x-ldo",
        .id = 3,
    },
    {
        .name = "atc260x-ldo",
        .id = 4,
    },
    {
        .name = "atc260x-ldo",
        .id = 5,
    },  
    {
        .name = "atc260x-ldo",
        .id = 6,
    },
    {
        .name = "atc260x-ldo",
        .id = 7,
    },  
    {
        .name = "atc260x-ldo",
        .id = 8,
    },  
    {
        .name = "atc260x-ldo",
        .id = 9,
    },  
    {
        .name = "atc260x-ldo",
        .id = 10,
    },
    {
        .name = "atc260x-ldo",
        .id = 11,
    },  

    /* Switch LDOs */
    {
        .name = "atc260x-switch-ldo",
        .id = 1,
    },
};

static int atc260x_pm_notifier_func(struct notifier_block *nb, unsigned long event,
	void *dummy)
{
    struct atc260x_dev *atc260x = atc260x_dev_handle;
    if(event == PM_HIBERNATION_PREPARE) 
    {
	    
	} 
	else if(event == PM_POST_HIBERNATION) 
	{
	    
		/*clear status*/
	    unsigned short tmp = 0;
	    tmp = atc260x_reg_read(atc260x, atc2603_PMU_UV_INT_EN);
	    if((tmp & 0x1) != 0)
	    {
	        printk("\n -----[%s]CLREA BIT------", __FUNCTION__);
	        /*
	         RTC_MSALM[7:0] -- PMU_SYS_CLT9 bit[7:0]
             RTC_MSALM[11:8] -- atc2603_PMU_SYS_CTL3[9:6]
            */
            
	        atc260x_set_bits(atc260x, atc2603_PMU_UV_INT_EN, 0x1, 0x0);
            atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL0, (0x1<<8), 0x0);	  

            printk("\n %s atc2603_PMU_UV_INT_EN:0x%x, atc2603_PMU_SYS_CTL0:0x%x", __FUNCTION__,
                atc260x_reg_read(atc260x, atc2603_PMU_UV_INT_EN),
                atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL0));              
                    
//	         tmp = atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL9)&0xfff;
             tmp = ((atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL3)&(0xf<<6))>>6);
             tmp = (tmp<<8);
             tmp |= (atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL9)&0xff);
             
             atc260x_reg_write(atc260x, atc2603_RTC_MSALM, tmp);  
            
             tmp = atc260x_reg_read(atc260x, atc2603_PMU_VBUS_CTL1)&0x1f;   
             atc260x_reg_write(atc260x, atc2603_RTC_HALM, tmp); 
             
             tmp = atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL8);
             atc260x_reg_write(atc260x, atc2603_RTC_YMDALM, tmp);     
	        
	        printk("\n %s atc2603_RTC_MSALM:0x%x, atc2603_RTC_HALM:0x%x, atc2603_RTC_YMDALM:0x%x",
	            __FUNCTION__,atc260x_reg_read(atc260x, atc2603_RTC_MSALM) ,
	            atc260x_reg_read(atc260x, atc2603_RTC_HALM),
	            atc260x_reg_read(atc260x, atc2603_RTC_YMDALM));
	        
	    }
	}
	return NOTIFY_OK;
}

static struct notifier_block atc260x_pm_notifier = {
	.notifier_call = atc260x_pm_notifier_func,
};


/*
 * Instantiate the generic non-control parts of the device.
 */
int atc260x_device_init(struct atc260x_dev *atc260x, int irq)
{
    struct atc260x_pdata *pdata = atc260x->dev->platform_data;
    int ret;

    mutex_init(&atc260x->io_lock);
    mutex_init(&atc260x->auxadc_lock);
    dev_set_drvdata(atc260x->dev, atc260x);

    atc260x_dev_handle = atc260x;

    ret = atc260x_reg_read(atc260x, ATC260X_MAGICNUM_REG) & 0x7fff;
    if (ret < 0) {
        dev_err(atc260x->dev, "Failed to read parent ID: %d\n", ret);
        goto err;
    }

    if (ret != ATC260X_MAGICNUM_REG_VALUE) {
        dev_err(atc260x->dev, "Device is not a ATC260X: Register 0x%x, value 0x%x != 0x%x\n", 
            ATC260X_MAGICNUM_REG, ret, ATC260X_MAGICNUM_REG_VALUE);
        ret = -EINVAL;
        goto err;
    }

    printk("[ATC260X] found atc260x connected (version: %c)\n",
        'A' + atc260x_get_version());

    if (pdata && pdata->pre_init) {
        ret = pdata->pre_init(atc260x);
        if (ret != 0) {
            dev_err(atc260x->dev, "pre_init() failed: %d\n", ret);
            goto err;
        }
    }

    ret = atc260x_mfp_init(atc260x);
    if (ret != 0)
        goto err;

    ret = atc260x_irq_init(atc260x, irq);
    if (ret != 0)
        goto err;

    /* The core device is up, instantiate the subdevices. */
    ret = mfd_add_devices(atc260x->dev, -1,
                  atc260x_devs, ARRAY_SIZE(atc260x_devs),
                  NULL, atc260x->irq_base);
    if (ret != 0) {
        dev_err(atc260x->dev, "Failed to add children\n");
        goto err_irq;
    }

    if (pdata && pdata->post_init) {
        ret = pdata->post_init(atc260x);
        if (ret != 0) {
            dev_err(atc260x->dev, "post_init() failed: %d\n", ret);
            goto err_irq;
        }
    }

    /* disable TP pad (X1, Y1, X2, Y2) for external TP chip */
    atc260x_set_bits(atc260x, atc2603_MFP_CTL1, 0x00e0, 0x0);

    ret = atc260x_create_attr(atc260x->dev);
    if (ret)
        goto err_irq;

	boot_info_read = atc260x_boot_info_read;
	boot_info_write = atc260x_boot_info_write;
	
	/*clear status*/
	{
	    unsigned short tmp = 0;
	    tmp = atc260x_reg_read(atc260x, atc2603_PMU_UV_INT_EN);
	    if((tmp & 0x1) != 0)
	    {
	        printk("\n -----[%s]CLREA BIT------", __FUNCTION__);
	        /*
	         RTC_MSALM[7:0] -- PMU_SYS_CLT9 bit[7:0]
             RTC_MSALM[11:8] -- atc2603_PMU_SYS_CTL3[9:6]
            */
            
	        atc260x_set_bits(atc260x, atc2603_PMU_UV_INT_EN, 0x1, 0x0);
            atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL0, (0x1<<8), 0x0);	  

            printk("\n %s atc2603_PMU_UV_INT_EN:0x%x, atc2603_PMU_SYS_CTL0:0x%x", __FUNCTION__,
                atc260x_reg_read(atc260x, atc2603_PMU_UV_INT_EN),
                atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL0));              
                    
//	         tmp = atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL9)&0xfff;
             tmp = ((atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL3)&(0xf<<6))>>6);
             tmp = (tmp<<8);
             tmp |= (atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL9)&0xff);
             
             atc260x_reg_write(atc260x, atc2603_RTC_MSALM, tmp);  
            
             tmp = atc260x_reg_read(atc260x, atc2603_PMU_VBUS_CTL1)&0x1f;   
             atc260x_reg_write(atc260x, atc2603_RTC_HALM, tmp); 
             
             tmp = atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL8);
             atc260x_reg_write(atc260x, atc2603_RTC_YMDALM, tmp);     
	        
	        printk("\n %s atc2603_RTC_MSALM:0x%x, atc2603_RTC_HALM:0x%x, atc2603_RTC_YMDALM:0x%x",
	            __FUNCTION__,atc260x_reg_read(atc260x, atc2603_RTC_MSALM) ,
	            atc260x_reg_read(atc260x, atc2603_RTC_HALM),
	            atc260x_reg_read(atc260x, atc2603_RTC_YMDALM));
	        
	    }
	}
	register_pm_notifier(&atc260x_pm_notifier);
    return 0;

err_irq:
//    atc260x_irq_exit(atc260x);
err:
    mfd_remove_devices(atc260x->dev);
    kfree(atc260x);
    return ret;
}

void atc260x_device_exit(struct atc260x_dev *atc260x)
{
    unregister_pm_notifier(&atc260x_pm_notifier);
    atc260x_remove_attr(atc260x->dev);
    mfd_remove_devices(atc260x->dev);
    atc260x_irq_exit(atc260x);
    kfree(atc260x);
}

static unsigned short saved_regs[][2] = {
    {atc2603_CMU_DEVRST, 0},
//    {atc2603_INTS_PD, 0},
    {atc2603_INTS_MSK, 0},
    {atc2603_PAD_EN, 0},
    {atc2603_MFP_CTL0, 0},
    {atc2603_MFP_CTL1, 0},
    {atc2603_PMU_SYS_CTL1, 0},
    {atc2603_PMU_LDO7_CTL, 0},	

//    {atc2603_TP_CTL0, 0},
 //   {atc2603_TP_CTL1, 0}
};

static void atc260x_save_regs(struct atc260x_dev *atc260x)
{
    int i;

    for (i = 0; i < ARRAY_SIZE(saved_regs); i++) {
        saved_regs[i][1] = atc260x_reg_read(atc260x, saved_regs[i][0]);
    }
}

static void atc260x_restore_regs(struct atc260x_dev *atc260x)
{
    int i;

    for (i = 0; i < ARRAY_SIZE(saved_regs); i++) {
        atc260x_reg_write(atc260x, saved_regs[i][0], saved_regs[i][1]);
    }
}

int atc260x_device_suspend(struct atc260x_dev *atc260x)
{
    /* TODO */
    unsigned int tmp;
    dev_info(atc260x->dev, "%s %d:\n", __FUNCTION__, __LINE__);

    disable_irq(atc260x->irq);
    
    atc260x_reg_read(atc260x, atc2603_CMU_DEVRST);
    atc260x_reg_read(atc260x, atc2603_INTS_PD);
    atc260x_reg_read(atc260x, atc2603_INTS_MSK);
    atc260x_reg_read(atc260x, atc2603_PAD_EN);
    atc260x_reg_read(atc260x, atc2603_MFP_CTL0);
    atc260x_reg_read(atc260x, atc2603_MFP_CTL1);
    atc260x_reg_read(atc260x, atc2603_TP_CTL0);
    atc260x_reg_read(atc260x, atc2603_TP_CTL1);

    atc260x_save_regs(atc260x);

		//disable LDO7
		tmp = atc260x_reg_read(atc260x, atc2603_PMU_LDO7_CTL);
		 atc260x_reg_write(atc260x, atc2603_PMU_LDO7_CTL, tmp & ~0x1);  	
	

// printk("\n %s atc2603_PMU_SYS_Pending:0x%x, atc2603_PMU_OV_Status:0x%x, atc2603_PMU_UV_Status:0x%x, atc2603_PMU_LDO8_CTL:0x%x\n",__FUNCTION__, 
//         atc260x_reg_read(atc260x, atc2603_PMU_SYS_Pending),
//          atc260x_reg_read(atc260x, atc2603_PMU_OV_Status),
//           atc260x_reg_read(atc260x, atc2603_PMU_UV_Status),
//           atc260x_reg_read(atc260x, atc2603_PMU_LDO8_CTL));

    return 0;
}

int atc260x_device_resume(struct atc260x_dev *atc260x)
{
    unsigned int tmp;
    atc260x_restore_regs(atc260x);

    atc260x_reg_read(atc260x, atc2603_CMU_DEVRST);
    atc260x_reg_read(atc260x, atc2603_INTS_PD);
    atc260x_reg_read(atc260x, atc2603_INTS_MSK);
    atc260x_reg_read(atc260x, atc2603_PAD_EN);
    atc260x_reg_read(atc260x, atc2603_MFP_CTL0);
    atc260x_reg_read(atc260x, atc2603_MFP_CTL1);
    atc260x_reg_read(atc260x, atc2603_TP_CTL0);
    atc260x_reg_read(atc260x, atc2603_TP_CTL1);

 //   atc260x_reg_write(atc260x, atc2603_INTS_PD, 0x0);
    atc260x_set_access_mode(atc260x, 
        ATC260X_SPI_ACCESS_MODE_NORMAL);
    
    //enable irq MUST after restore registers
    enable_irq(atc260x->irq); 
    return 0;
}

MODULE_DESCRIPTION("Core support for the ATC260X PMIC");
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Actions Semi, Inc");

