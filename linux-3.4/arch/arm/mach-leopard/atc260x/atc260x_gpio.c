/*
 * atc260x-gpio.c  --  gpiolib support for ATC260X
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

#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/gpio.h>
#include <linux/platform_device.h>
#include <linux/seq_file.h>

#include <asm/mach-actions/atc260x.h>
#include <asm/mach-actions/atc260x_pdata.h>
#include <mach/atc260x/atc260x_dev.h>

#define GPIO_REG_INDEX(gpio)        ((gpio) / 16)
#define GPIO_REG_SHIFT(gpio)        ((gpio) % 16)     
#define GPIO_REG_BIT(gpio)          (1 << GPIO_REG_SHIFT(gpio))

#define SGPIO_0_EN                  (0x01 << 15)
#define SGPIO_0_OUT_EN              (0x01 << 14)
#define SGPIO_0_IN_EN               (0x01 << 13)
#define SGPIO_0_DAT                 (0x01 << 12)

#define SGPIO_1_EN                  (0x01 << 4)
#define SGPIO_1_OUT_EN              (0x01 << 7)
#define SGPIO_1_IN_EN               (0x01 << 6)
#define SGPIO_1_DAT                 (0x01 << 5)


#define SGPIO_2_EN                  (0x01 << 3)
#define SGPIO_2_OUT_EN              (0x01 << 2)
#define SGPIO_2_IN_EN               (0x01 << 1)
#define SGPIO_2_DAT                 (0x01 << 0)


struct gpio_mfp_map
{
    unsigned int reg;
    unsigned int mask;
    unsigned int val;
};

static struct gpio_mfp_map atc260x_gpio_mfp_map[ATC260X_GPIO_NUM] = {
    /* reg              mask        val */
    {atc2603_MFP_CTL1,   0x0c00,     0x0800},    /* GPIO0 */
    {atc2603_MFP_CTL1,   0x0c00,     0x0800},    /* GPIO1 */
    {atc2603_MFP_CTL1,   0x3000,     0x2000},    /* GPIO2 */
    {atc2603_MFP_CTL1,   0x3000,     0x2000},    /* GPIO3 */
    {atc2603_MFP_CTL1,   0xc000,     0x8000},    /* GPIO4 */
    {atc2603_MFP_CTL1,   0xc000,     0x8000},    /* GPIO5 */
    {atc2603_MFP_CTL0,   0x0010,     0x0010},    /* GPIO6 */
    {atc2603_MFP_CTL0,   0x0010,     0x0010},    /* GPIO7 */
    {atc2603_MFP_CTL0,   0x000c,     0x0004},    /* GPIO8 */
    {atc2603_MFP_CTL0,   0x0020,     0x0020},    /* GPIO9 */
    {atc2603_MFP_CTL0,   0x0020,     0x0020},    /* GPIO10 */
    {atc2603_MFP_CTL0,   0x0020,     0x0020},    /* GPIO11 */
    {atc2603_MFP_CTL1,   0x0001,     0x0001},    /* GPIO12 */
    {atc2603_MFP_CTL1,   0x0002,     0x0002},    /* GPIO13 */
    {atc2603_MFP_CTL1,   0x0004,     0x0004},    /* GPIO14 */
    {atc2603_MFP_CTL1,   0x0008,     0x0008},    /* GPIO15 */
    {atc2603_MFP_CTL1,   0x0010,     0x0010},    /* GPIO16 */
    {0xffffffff,             0,          0},    /* GPIO17, reserved for TP */
    {0xffffffff,             0,          0},    /* GPIO18, reserved for TP */
    {0xffffffff,             0,          0},    /* GPIO19, reserved for TP */
    {0xffffffff,             0,          0},    /* GPIO20, reserved for TP */
    {atc2603_MFP_CTL0,   0x0003,     0x0001},    /* GPIO21 */
    {atc2603_MFP_CTL0,   0x0003,     0x0001},    /* GPIO22 */
    {atc2603_MFP_CTL0,   0x0003,     0x0001},    /* GPIO23 */
    {atc2603_MFP_CTL0,   0x0003,     0x0001},    /* GPIO24 */
    {atc2603_MFP_CTL0,   0x0003,     0x0001},    /* GPIO25 */
    {atc2603_MFP_CTL0,   0x0003,     0x0001},    /* GPIO26 */
    {atc2603_MFP_CTL0,   0x0003,     0x0001},    /* GPIO27 */
    {atc2603_MFP_CTL0,   0x0040,     0x0040},    /* GPIO28 */
    {atc2603_MFP_CTL0,   0x0080,     0x0080},    /* GPIO29 */
    {              0,        0,          0},    /* GPIO30, dedicated GPIO */
    {              0,        0,          0},    /* GPIO31, dedicated GPIO */

};

struct atc260x_gpio {
    struct atc260x_dev *atc260x;
    struct gpio_chip gpio_chip;

};

static inline struct atc260x_gpio *to_atc260x_gpio(struct gpio_chip *chip)
{
    return container_of(chip, struct atc260x_gpio, gpio_chip);
}

static int atc260x_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
{
    struct atc260x_gpio *atc260x_gpio = to_atc260x_gpio(chip);
    struct atc260x_dev *atc260x = atc260x_gpio->atc260x;
    int ret, reg;
    
    if (offset > ATC260X_GPIO_NUM){
    	// add for s gpio
    	 offset = offset - ATC260X_GPIO_NUM;
    	 switch(offset){
    	 	case 1:
    	 	atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL4,
            SGPIO_0_IN_EN,
            SGPIO_0_IN_EN);
        break;
    	 	case 2:
    	 	atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL4,
            SGPIO_1_IN_EN,
            SGPIO_1_IN_EN);
        break;
    	 	case 3:	
    	 	 atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL3,
            SGPIO_2_IN_EN,
            SGPIO_2_IN_EN);
        break;
    	 	default :
    	 		return -EINVAL;
    	 }
    	 return 0;        
    }

    /* clear output enable bit */
    reg = atc2603_GPIO_OUTEN0 + GPIO_REG_INDEX(offset);
    ret = atc260x_set_bits(atc260x, reg,
                   GPIO_REG_BIT(offset), 0);
    if (ret < 0) {
        dev_err(atc260x->dev,
            "GPIO control %d set failed reg 0x%x\n",
            offset, reg);
        return -1;
    }

    /* set input enable bit */
    reg = atc2603_GPIO_INEN0 + GPIO_REG_INDEX(offset);    
    ret = atc260x_set_bits(atc260x, reg,
                   GPIO_REG_BIT(offset), GPIO_REG_BIT(offset));
    if (reg < 0) {
        dev_err(atc260x->dev,
            "GPIO control %d set failed reg 0x%x\n",
            offset, reg);
        return -1;
    }

    return 0;
}

static int atc260x_gpio_get(struct gpio_chip *chip, unsigned offset)
{
    struct atc260x_gpio *atc260x_gpio = to_atc260x_gpio(chip);
    struct atc260x_dev *atc260x = atc260x_gpio->atc260x;
    int ret;
   
		if (offset > ATC260X_GPIO_NUM){
    	// add for s gpio
    	 offset = offset - ATC260X_GPIO_NUM;
    	 switch(offset){
    	 	case 1:
    	 	ret = ((atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL4) >> 12) & 0x01);
    	 	break;
    	 	case 2:
    	 	ret = ((atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL4) >> 5) & 0x01);
    	  break;
    	 	case 3:	
    	 	ret =  atc260x_reg_read(atc260x, atc2603_PMU_SYS_CTL3) & 0x01;
    	  break;
    	 	default :
    	 		return -EINVAL;
    	 }
     	 return ret;        
    }
    
    ret = atc260x_reg_read(atc260x, atc2603_GPIO_DAT0 + GPIO_REG_INDEX(offset));
    if (ret < 0)
        return ret;

    if (ret & GPIO_REG_BIT(offset))
        return 1;
    else
        return 0;
}

static void atc260x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
{
    struct atc260x_gpio *atc260x_gpio = to_atc260x_gpio(chip);
    struct atc260x_dev *atc260x = atc260x_gpio->atc260x;
 		if (offset > ATC260X_GPIO_NUM){
		    	// add for s gpio
		    	 offset = offset - ATC260X_GPIO_NUM;
		    	 switch(offset){
		    	 	case 1:
		    	  atc260x_set_bits(atc260x,atc2603_PMU_SYS_CTL4, SGPIO_0_DAT,value << 12 );
		    	  break;
		    	 	case 2:
		    	  atc260x_set_bits(atc260x,atc2603_PMU_SYS_CTL4, SGPIO_1_DAT,value << 5 );
		    	  break;
		    	 	case 3:		
		    	  atc260x_set_bits(atc260x, atc2603_PMU_SYS_CTL3,SGPIO_2_DAT,value);
		    	 	break;
		    	 	default :
		    	 		return;
		    	 }
		    	 return ;        
		}
    atc260x_set_bits(atc260x, atc2603_GPIO_DAT0 + GPIO_REG_INDEX(offset), 
            GPIO_REG_BIT(offset), value << GPIO_REG_SHIFT(offset));
}

static int atc260x_gpio_direction_out(struct gpio_chip *chip,
                     unsigned offset, int value)
{
    struct atc260x_gpio *atc260x_gpio = to_atc260x_gpio(chip);
    struct atc260x_dev *atc260x = atc260x_gpio->atc260x;
    int ret, reg;
    
    if (offset > ATC260X_GPIO_NUM){
    	// add for s gpio
    	 offset = offset - ATC260X_GPIO_NUM;
    	 switch(offset){
    	 	case 1:
    	 	atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL4,
            SGPIO_0_OUT_EN,
            SGPIO_0_OUT_EN);
        break;
    	 	case 2:
    	 	atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL4,
            SGPIO_1_OUT_EN,
            SGPIO_1_OUT_EN);
        break;
    	 	case 3:	
    	 	 atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL3,
            SGPIO_2_OUT_EN,
            SGPIO_2_OUT_EN);
        break;
    	 	default :
    	 		return -EINVAL;
    	 }
    	 atc260x_gpio_set(chip, offset + ATC260X_GPIO_NUM, value);
    	 return 0;        
    }

    /* clear input enable bit */
    reg = atc2603_GPIO_INEN0 + GPIO_REG_INDEX(offset);
    ret = atc260x_set_bits(atc260x, reg,
                   GPIO_REG_BIT(offset), 0);
    if (ret < 0) {
        dev_err(atc260x->dev,
            "GPIO control %d set failed reg 0x%x\n",
            offset, reg);
        return -1;
    }

    /* Can only set GPIO state once it's in output mode */
    atc260x_gpio_set(chip, offset, value);

    /* set output enable bit */
    reg = atc2603_GPIO_OUTEN0 + GPIO_REG_INDEX(offset);    
    ret = atc260x_set_bits(atc260x, reg,
                   GPIO_REG_BIT(offset), GPIO_REG_BIT(offset));
    if (reg < 0) {
        dev_err(atc260x->dev,
            "GPIO control %d set failed reg 0x%x\n",
            offset, reg);
        return -1;
    }

    return 0;
}

static int atc260x_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
                    unsigned debounce)
{
//  struct atc260x_gpio *atc260x_gpio = to_atc260x_gpio(chip);
//  struct atc260x_dev *atc260x = atc260x_gpio->atc260x;

    return 0;
}

static int atc260x_gpio_request(struct gpio_chip *chip, unsigned offset)
{
    struct atc260x_gpio *atc260x_gpio = to_atc260x_gpio(chip);
    struct atc260x_dev *atc260x = atc260x_gpio->atc260x;

    dev_info(atc260x->dev, "request gpio %u\n", offset);
    if (offset > ATC260X_GPIO_NUM){
    	// add for s gpio
    	 offset = offset - ATC260X_GPIO_NUM;
    	 switch(offset){
    	 	case 1:
    	 	atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL4,
            SGPIO_0_EN,
            SGPIO_0_EN);
          break;
    	 	case 2:
    	 	atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL4,
            SGPIO_1_EN,
            SGPIO_1_EN);
           break;
    	 	case 3:	
    	 	 atc260x_set_bits(atc260x,
            atc2603_PMU_SYS_CTL3,
            SGPIO_2_EN,
            SGPIO_2_EN);
         break;
        
    	 	default :
    	 		return -EINVAL;
    	 } 
    	 return 0;       
    }
    if (atc260x_gpio_mfp_map[offset].reg == 0xffffffff)
        return -EBUSY;

    if (atc260x_gpio_mfp_map[offset].mask != 0) {
        atc260x_set_bits(atc260x,
            atc260x_gpio_mfp_map[offset].reg,
            atc260x_gpio_mfp_map[offset].mask,
            atc260x_gpio_mfp_map[offset].val);
    }

    return 0;
}

#ifdef CONFIG_DEBUG_FS
static void atc260x_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
{
    struct atc260x_gpio *atc260x_gpio = to_atc260x_gpio(chip);
    struct atc260x_dev *atc260x = atc260x_gpio->atc260x;
    int ret, i;
    
    for (i = 0; i < 6; i++) {        
        ret = atc260x_reg_read(atc260x, atc2603_GPIO_OUTEN0 + i);
        if (ret < 0) {
            dev_err(atc260x->dev,
                "GPIO controlread failed: %d\n",
                 atc2603_GPIO_OUTEN0 + i);
            seq_printf(s, "\n");
            continue;
        }
        seq_printf(s, "  gpio reg %d = %04x\n", atc2603_GPIO_OUTEN0 + i, ret);        
    }

}
#else
#define atc260x_gpio_dbg_show NULL
#endif

static struct gpio_chip template_chip = {
    .label              = "atc260x_gpio",
    .owner              = THIS_MODULE,
    .request            = atc260x_gpio_request,
    .direction_input    = atc260x_gpio_direction_in,
    .get                = atc260x_gpio_get,
    .direction_output   = atc260x_gpio_direction_out,
    .set                = atc260x_gpio_set,
    .to_irq             = NULL,
    .set_debounce       = atc260x_gpio_set_debounce,
    .dbg_show           = atc260x_gpio_dbg_show,
    .can_sleep          = 1,
};

static int __devinit atc260x_gpio_probe(struct platform_device *pdev)
{
    struct atc260x_dev *atc260x = dev_get_drvdata(pdev->dev.parent);
    struct atc260x_pdata *pdata = atc260x->dev->platform_data;
    struct atc260x_gpio *atc260x_gpio;
    int ret;

    printk("[ATC260X] Probing gpio\n");

    atc260x_gpio = kzalloc(sizeof(*atc260x_gpio), GFP_KERNEL);
    if (atc260x_gpio == NULL)
        return -ENOMEM;

    atc260x_gpio->atc260x = atc260x;
    atc260x_gpio->gpio_chip = template_chip;
    atc260x_gpio->gpio_chip.ngpio = ATC260X_GPIO_NUM + 5;
    atc260x_gpio->gpio_chip.dev = &pdev->dev;
    if (pdata && pdata->gpio_base)
        atc260x_gpio->gpio_chip.base = pdata->gpio_base;
    else
        atc260x_gpio->gpio_chip.base = -1;
        
    ret = gpiochip_add(&atc260x_gpio->gpio_chip);
    if (ret < 0) {
        dev_err(&pdev->dev, "Could not register gpiochip, %d\n",
            ret);
        goto err;
    }

    platform_set_drvdata(pdev, atc260x_gpio);

    return ret;

err:
    kfree(atc260x_gpio);
    return ret;
}

static int __devexit atc260x_gpio_remove(struct platform_device *pdev)
{
    struct atc260x_gpio *atc260x_gpio = platform_get_drvdata(pdev);
    int ret;

    ret = gpiochip_remove(&atc260x_gpio->gpio_chip);
    if (ret == 0)
        kfree(atc260x_gpio);

    return ret;
}

static struct platform_driver atc260x_gpio_driver = {
    .driver.name    = "atc260x-gpio",
    .driver.owner   = THIS_MODULE,
    .probe      = atc260x_gpio_probe,
    .remove     = __devexit_p(atc260x_gpio_remove),
};

static int __init atc260x_gpio_init(void)
{
    return platform_driver_register(&atc260x_gpio_driver);
}
subsys_initcall(atc260x_gpio_init);

static void __exit atc260x_gpio_exit(void)
{
    platform_driver_unregister(&atc260x_gpio_driver);
}
module_exit(atc260x_gpio_exit);

MODULE_AUTHOR("Actions Semi, Inc");
MODULE_DESCRIPTION("GPIO interface for ATC260X PMIC");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:atc260x-gpio");

