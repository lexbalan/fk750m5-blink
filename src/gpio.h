
#ifndef GPIO_H
#define GPIO_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

#define GPIO_GPIOA_BASE  (0x58020000)
#define GPIO_GPIOB_BASE  (0x58020400)
#define GPIO_GPIOC_BASE  (0x58020800)
#define GPIO_GPIOD_BASE  (0x58020C00)
#define GPIO_GPIOE_BASE  (0x58021000)
#define GPIO_GPIOF_BASE  (0x58021400)
#define GPIO_GPIOG_BASE  (0x58021800)
#define GPIO_GPIOH_BASE  (0x58021C00)
#define GPIO_GPIOI_BASE  (0x58022000)
#define GPIO_GPIOJ_BASE  (0x58022400)
#define GPIO_GPIOK_BASE  (0x58022800)


typedef struct gpio_gpioregisters gpio_GPIORegisters;
struct gpio_gpioregisters {
	uint32_t moder;
	uint32_t otyper;
	uint32_t ospeedr;
	uint32_t pupdr;
	uint32_t idr;
	uint32_t odr;
	uint32_t bsrr;
	uint32_t lckr;
	uint32_t afrl;
	uint32_t afrh;
};

#define GPIO_GPIO_A  ((volatile gpio_GPIORegisters *)GPIO_GPIOA_BASE)
#define GPIO_GPIO_B  ((volatile gpio_GPIORegisters *)GPIO_GPIOB_BASE)
#define GPIO_GPIO_C  ((volatile gpio_GPIORegisters *)GPIO_GPIOC_BASE)
#define GPIO_GPIO_D  ((volatile gpio_GPIORegisters *)GPIO_GPIOD_BASE)
#define GPIO_GPIO_E  ((volatile gpio_GPIORegisters *)GPIO_GPIOE_BASE)
#define GPIO_GPIO_F  ((volatile gpio_GPIORegisters *)GPIO_GPIOF_BASE)
#define GPIO_GPIO_G  ((volatile gpio_GPIORegisters *)GPIO_GPIOG_BASE)
#define GPIO_GPIO_H  ((volatile gpio_GPIORegisters *)GPIO_GPIOH_BASE)
#define GPIO_GPIO_I  ((volatile gpio_GPIORegisters *)GPIO_GPIOI_BASE)
#define GPIO_GPIO_J  ((volatile gpio_GPIORegisters *)GPIO_GPIOJ_BASE)
#define GPIO_GPIO_K  ((volatile gpio_GPIORegisters *)GPIO_GPIOK_BASE)

#define GPIO_GPIO_PORTS  {GPIO_GPIO_A, GPIO_GPIO_B, GPIO_GPIO_C, GPIO_GPIO_D, GPIO_GPIO_E, GPIO_GPIO_F, GPIO_GPIO_G, GPIO_GPIO_H, GPIO_GPIO_I, GPIO_GPIO_J, GPIO_GPIO_K}

#define GPIO_GPIO_PORT_MODE_INPUT  0x0
#define GPIO_GPIO_PORT_MODE_OUTPUT  0x1
#define GPIO_GPIO_PORT_MODE_ALTERNATE  0x2
#define GPIO_GPIO_PORT_MODE_ANALOG  0x3

#define GPIO_GPIO_PORT_OUTPUT_PUSH_PULL  0x0
#define GPIO_GPIO_PORT_OUTPUT_OPEN_DRAIN  0x1

#define GPIO_GPIO_PORT_SPEED_LOW  0x0
#define GPIO_GPIO_PORT_SPEED_MEDIUM  0x1
#define GPIO_GPIO_PORT_SPEED_HIGH  0x2
#define GPIO_GPIO_PORT_SPEED_VERY_HIGH  0x3

#define GPIO_GPIO_PORT_NO_PULL  0x0
#define GPIO_GPIO_PORT_PULL_UP  0x1
#define GPIO_GPIO_PORT_PULL_DOWN  0x2
#define GPIO_GPIO_PORT_RESERVED  0x3

#endif /* GPIO_H */
