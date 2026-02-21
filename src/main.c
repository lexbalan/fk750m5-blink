
// STM32H750 blink exampe
// LED_BLUE is on PC13

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "gpio.h"

/*
  For STM32H750, SWD uses:																									  
  - PA13 — SWDIO (data)
  - PA14 — SWCLK (clock)
  - PB3 — SWO (optional, trace output)
  - NRST — reset line (for connect-under-reset)
*/


/* RCC registers */
#define RCC_BASE  (0x58024400)
#define RCC_CR  ((volatile uint32_t *)(RCC_BASE + 0x0))
#define RCC_CFGR  ((volatile uint32_t *)(RCC_BASE + 0x10))
#define RCC_AHB4_ENR  ((volatile uint32_t *)(RCC_BASE + 0xE0))


// const not works?!
static uint32_t xgpioPorts[11] = {
	GPIO_GPIOA_BASE, GPIO_GPIOB_BASE, GPIO_GPIOC_BASE, GPIO_GPIOD_BASE,
	GPIO_GPIOE_BASE, GPIO_GPIOF_BASE, GPIO_GPIOG_BASE, GPIO_GPIOH_BASE,
	GPIO_GPIOI_BASE, GPIO_GPIOJ_BASE, GPIO_GPIOK_BASE
};

__attribute__((always_inline))
static inline void mmioWrite32(uint32_t addr, uint32_t value) {
	*((uint32_t *)addr) = value;
}


__attribute__((always_inline))
static inline uint32_t mmioRead32(uint32_t addr) {
	return *((uint32_t *)addr);
}



/* SysTick registers */
#define SYSTICK_CSR  (((volatile uint32_t *)0xE000E010))
#define SYSTICK_RVR  (((volatile uint32_t *)0xE000E014))
#define SYSTICK_CVR  (((volatile uint32_t *)0xE000E018))

static volatile uint32_t ticks = 0;

void SysTick_Handler(void) {
	ticks = ticks + 1;
}

static void delay_ms(uint32_t ms) {
	const uint32_t end = ticks + ms;
	while (ticks < end) {
		// Wait
	}
}

static void systick_init(uint32_t sysclkHz) {
	*SYSTICK_RVR = ((sysclkHz / 1000) - 1);
	*SYSTICK_CVR = 0x0;
	*SYSTICK_CSR = 0x7; // Enable, interrupt, processor clock
}


static void gpio_init(void) {
	/* Enable clocks for GPIOA..GPIOK (bits 0..10 of AHB4ENR) */
	*RCC_AHB4_ENR = *RCC_AHB4_ENR | 0x7FF;

	/* Brief delay for clocks to stabilize */
	uint32_t dummy = *RCC_AHB4_ENR;
	(void)dummy;

	GPIO_GPIO_C->moder = GPIO_GPIO_PORT_MODE_OUTPUT << (13 * 2); // Set PC13 (LED pin) as output, others as input
}


static void delay2_ms(uint32_t ms) {
	volatile uint32_t cnt = ms * 10000;
	while (cnt > 0) {
		cnt = cnt - 1;
	}
}


int32_t main(void) {
	/* Defat after reset: HSI at 64 MHz */
	systick_init(64000000);
	gpio_init();

	while (true) {
		delay_ms(500);
		GPIO_GPIO_C->odr = (uint32_t)1 << 13;
		delay_ms(500);
		GPIO_GPIO_C->odr = 0x0;
	}

	return 0;
}


