/**
 * Startup code for STM32H750XBH6 (Cortex-M7)
 */

    .syntax unified
    .cpu cortex-m7
    .fpu softvfp
    .thumb

.global g_vectors
.global Default_Handler

    .section .text.Reset_Handler
    .weak   Reset_Handler
    .type   Reset_Handler, %function
Reset_Handler:
    /* Set stack pointer */
    ldr   sp, =_estack

    /* Copy .data from FLASH to RAM */
    ldr   r0, =_sdata
    ldr   r1, =_edata
    ldr   r2, =_sidata
    movs  r3, #0
    b     .copy_data_check
.copy_data_loop:
    ldr   r4, [r2, r3]
    str   r4, [r0, r3]
    adds  r3, r3, #4
.copy_data_check:
    adds  r4, r0, r3
    cmp   r4, r1
    bcc   .copy_data_loop

    /* Zero fill .bss */
    ldr   r2, =_sbss
    ldr   r4, =_ebss
    movs  r3, #0
    b     .zero_bss_check
.zero_bss_loop:
    str   r3, [r2]
    adds  r2, r2, #4
.zero_bss_check:
    cmp   r2, r4
    bcc   .zero_bss_loop

    /* Call main */
    bl    main
    bx    lr
.size Reset_Handler, .-Reset_Handler

/**
 * Default handler for unimplemented interrupts
 */
    .section .text.Default_Handler, "ax", %progbits
Default_Handler:
    b     Default_Handler
.size Default_Handler, .-Default_Handler

/**
 * Vector table - STM32H750xx
 */
    .section .isr_vector, "a", %progbits
    .type  g_vectors, %object
    .size  g_vectors, .-g_vectors
g_vectors:
    .word  _estack
    .word  Reset_Handler
    .word  NMI_Handler
    .word  HardFault_Handler
    .word  MemManage_Handler
    .word  BusFault_Handler
    .word  UsageFault_Handler
    .word  0
    .word  0
    .word  0
    .word  0
    .word  SVC_Handler
    .word  DebugMon_Handler
    .word  0
    .word  PendSV_Handler
    .word  SysTick_Handler

    /* External interrupts (IRQ 0-149 for STM32H750) */
    .word  WWDG_IRQHandler                 /* 0 */
    .word  PVD_AVD_IRQHandler              /* 1 */
    .word  TAMP_STAMP_IRQHandler           /* 2 */
    .word  RTC_WKUP_IRQHandler             /* 3 */
    .word  FLASH_IRQHandler                /* 4 */
    .word  RCC_IRQHandler                  /* 5 */
    .word  EXTI0_IRQHandler                /* 6 */
    .word  EXTI1_IRQHandler                /* 7 */
    .word  EXTI2_IRQHandler                /* 8 */
    .word  EXTI3_IRQHandler                /* 9 */
    .word  EXTI4_IRQHandler                /* 10 */
    .word  DMA1_Stream0_IRQHandler         /* 11 */
    .word  DMA1_Stream1_IRQHandler         /* 12 */
    .word  DMA1_Stream2_IRQHandler         /* 13 */
    .word  DMA1_Stream3_IRQHandler         /* 14 */
    .word  DMA1_Stream4_IRQHandler         /* 15 */
    .word  DMA1_Stream5_IRQHandler         /* 16 */
    .word  DMA1_Stream6_IRQHandler         /* 17 */
    .word  ADC_IRQHandler                  /* 18 */
    .word  FDCAN1_IT0_IRQHandler           /* 19 */
    .word  FDCAN2_IT0_IRQHandler           /* 20 */
    .word  FDCAN1_IT1_IRQHandler           /* 21 */
    .word  FDCAN2_IT1_IRQHandler           /* 22 */
    .word  EXTI9_5_IRQHandler              /* 23 */
    .word  TIM1_BRK_IRQHandler             /* 24 */
    .word  TIM1_UP_IRQHandler              /* 25 */
    .word  TIM1_TRG_COM_IRQHandler         /* 26 */
    .word  TIM1_CC_IRQHandler              /* 27 */
    .word  TIM2_IRQHandler                 /* 28 */
    .word  TIM3_IRQHandler                 /* 29 */
    .word  TIM4_IRQHandler                 /* 30 */
    .word  I2C1_EV_IRQHandler              /* 31 */
    .word  I2C1_ER_IRQHandler              /* 32 */
    .word  I2C2_EV_IRQHandler              /* 33 */
    .word  I2C2_ER_IRQHandler              /* 34 */
    .word  SPI1_IRQHandler                 /* 35 */
    .word  SPI2_IRQHandler                 /* 36 */
    .word  USART1_IRQHandler               /* 37 */
    .word  USART2_IRQHandler               /* 38 */
    .word  USART3_IRQHandler               /* 39 */
    .word  EXTI15_10_IRQHandler            /* 40 */
    .word  RTC_Alarm_IRQHandler            /* 41 */
    .word  0                               /* 42 */
    .word  TIM8_BRK_TIM12_IRQHandler       /* 43 */
    .word  TIM8_UP_TIM13_IRQHandler        /* 44 */
    .word  TIM8_TRG_COM_TIM14_IRQHandler   /* 45 */
    .word  TIM8_CC_IRQHandler              /* 46 */
    .word  DMA1_Stream7_IRQHandler         /* 47 */
    .word  FMC_IRQHandler                  /* 48 */
    .word  SDMMC1_IRQHandler               /* 49 */
    .word  TIM5_IRQHandler                 /* 50 */
    .word  SPI3_IRQHandler                 /* 51 */
    .word  UART4_IRQHandler                /* 52 */
    .word  UART5_IRQHandler                /* 53 */
    .word  TIM6_DAC_IRQHandler             /* 54 */
    .word  TIM7_IRQHandler                 /* 55 */
    .word  DMA2_Stream0_IRQHandler         /* 56 */
    .word  DMA2_Stream1_IRQHandler         /* 57 */
    .word  DMA2_Stream2_IRQHandler         /* 58 */
    .word  DMA2_Stream3_IRQHandler         /* 59 */
    .word  DMA2_Stream4_IRQHandler         /* 60 */
    .word  ETH_IRQHandler                  /* 61 */
    .word  ETH_WKUP_IRQHandler             /* 62 */
    .word  FDCAN_CAL_IRQHandler            /* 63 */
    .word  0                               /* 64 */
    .word  0                               /* 65 */
    .word  0                               /* 66 */
    .word  0                               /* 67 */
    .word  DMA2_Stream5_IRQHandler         /* 68 */
    .word  DMA2_Stream6_IRQHandler         /* 69 */
    .word  DMA2_Stream7_IRQHandler         /* 70 */
    .word  USART6_IRQHandler               /* 71 */
    .word  I2C3_EV_IRQHandler              /* 72 */
    .word  I2C3_ER_IRQHandler              /* 73 */
    .word  OTG_HS_EP1_OUT_IRQHandler       /* 74 */
    .word  OTG_HS_EP1_IN_IRQHandler        /* 75 */
    .word  OTG_HS_WKUP_IRQHandler          /* 76 */
    .word  OTG_HS_IRQHandler               /* 77 */
    .word  DCMI_IRQHandler                 /* 78 */
    .word  0                               /* 79 */
    .word  RNG_IRQHandler                  /* 80 */
    .word  FPU_IRQHandler                  /* 81 */
    .word  UART7_IRQHandler                /* 82 */
    .word  UART8_IRQHandler                /* 83 */
    .word  SPI4_IRQHandler                 /* 84 */
    .word  SPI5_IRQHandler                 /* 85 */
    .word  SPI6_IRQHandler                 /* 86 */
    .word  SAI1_IRQHandler                 /* 87 */
    .word  LTDC_IRQHandler                 /* 88 */
    .word  LTDC_ER_IRQHandler              /* 89 */
    .word  DMA2D_IRQHandler                /* 90 */
    .word  SAI2_IRQHandler                 /* 91 */
    .word  QUADSPI_IRQHandler              /* 92 */
    .word  LPTIM1_IRQHandler               /* 93 */
    .word  CEC_IRQHandler                  /* 94 */
    .word  I2C4_EV_IRQHandler              /* 95 */
    .word  I2C4_ER_IRQHandler              /* 96 */
    .word  SPDIF_RX_IRQHandler             /* 97 */
    .word  OTG_FS_EP1_OUT_IRQHandler       /* 98 */
    .word  OTG_FS_EP1_IN_IRQHandler        /* 99 */
    .word  OTG_FS_WKUP_IRQHandler          /* 100 */
    .word  OTG_FS_IRQHandler               /* 101 */
    .word  DMAMUX1_OVR_IRQHandler          /* 102 */
    .word  HRTIM1_Master_IRQHandler        /* 103 */
    .word  HRTIM1_TIMA_IRQHandler          /* 104 */
    .word  HRTIM1_TIMB_IRQHandler          /* 105 */
    .word  HRTIM1_TIMC_IRQHandler          /* 106 */
    .word  HRTIM1_TIMD_IRQHandler          /* 107 */
    .word  HRTIM1_TIME_IRQHandler          /* 108 */
    .word  HRTIM1_FLT_IRQHandler           /* 109 */
    .word  DFSDM1_FLT0_IRQHandler          /* 110 */
    .word  DFSDM1_FLT1_IRQHandler          /* 111 */
    .word  DFSDM1_FLT2_IRQHandler          /* 112 */
    .word  DFSDM1_FLT3_IRQHandler          /* 113 */
    .word  SAI3_IRQHandler                 /* 114 */
    .word  SWPMI1_IRQHandler               /* 115 */
    .word  TIM15_IRQHandler                /* 116 */
    .word  TIM16_IRQHandler                /* 117 */
    .word  TIM17_IRQHandler                /* 118 */
    .word  MDIOS_WKUP_IRQHandler           /* 119 */
    .word  MDIOS_IRQHandler                /* 120 */
    .word  JPEG_IRQHandler                 /* 121 */
    .word  MDMA_IRQHandler                 /* 122 */
    .word  0                               /* 123 */
    .word  SDMMC2_IRQHandler               /* 124 */
    .word  HSEM1_IRQHandler                /* 125 */
    .word  0                               /* 126 */
    .word  ADC3_IRQHandler                 /* 127 */
    .word  DMAMUX2_OVR_IRQHandler          /* 128 */
    .word  BDMA_Channel0_IRQHandler        /* 129 */
    .word  BDMA_Channel1_IRQHandler        /* 130 */
    .word  BDMA_Channel2_IRQHandler        /* 131 */
    .word  BDMA_Channel3_IRQHandler        /* 132 */
    .word  BDMA_Channel4_IRQHandler        /* 133 */
    .word  BDMA_Channel5_IRQHandler        /* 134 */
    .word  BDMA_Channel6_IRQHandler        /* 135 */
    .word  BDMA_Channel7_IRQHandler        /* 136 */
    .word  COMP1_IRQHandler                /* 137 */
    .word  LPTIM2_IRQHandler               /* 138 */
    .word  LPTIM3_IRQHandler               /* 139 */
    .word  LPTIM4_IRQHandler               /* 140 */
    .word  LPTIM5_IRQHandler               /* 141 */
    .word  LPUART1_IRQHandler              /* 142 */
    .word  0                               /* 143 */
    .word  CRS_IRQHandler                  /* 144 */
    .word  ECC_IRQHandler                  /* 145 */
    .word  SAI4_IRQHandler                 /* 146 */
    .word  0                               /* 147 */
    .word  0                               /* 148 */
    .word  WAKEUP_PIN_IRQHandler           /* 149 */

/**
 * Weak aliases - all point to Default_Handler unless overridden
 */
    .weak      NMI_Handler
    .thumb_set NMI_Handler, Default_Handler
    .weak      HardFault_Handler
    .thumb_set HardFault_Handler, Default_Handler
    .weak      MemManage_Handler
    .thumb_set MemManage_Handler, Default_Handler
    .weak      BusFault_Handler
    .thumb_set BusFault_Handler, Default_Handler
    .weak      UsageFault_Handler
    .thumb_set UsageFault_Handler, Default_Handler
    .weak      SVC_Handler
    .thumb_set SVC_Handler, Default_Handler
    .weak      DebugMon_Handler
    .thumb_set DebugMon_Handler, Default_Handler
    .weak      PendSV_Handler
    .thumb_set PendSV_Handler, Default_Handler
    .weak      SysTick_Handler
    .thumb_set SysTick_Handler, Default_Handler
    .weak      WWDG_IRQHandler
    .thumb_set WWDG_IRQHandler, Default_Handler
    .weak      PVD_AVD_IRQHandler
    .thumb_set PVD_AVD_IRQHandler, Default_Handler
    .weak      TAMP_STAMP_IRQHandler
    .thumb_set TAMP_STAMP_IRQHandler, Default_Handler
    .weak      RTC_WKUP_IRQHandler
    .thumb_set RTC_WKUP_IRQHandler, Default_Handler
    .weak      FLASH_IRQHandler
    .thumb_set FLASH_IRQHandler, Default_Handler
    .weak      RCC_IRQHandler
    .thumb_set RCC_IRQHandler, Default_Handler
    .weak      EXTI0_IRQHandler
    .thumb_set EXTI0_IRQHandler, Default_Handler
    .weak      EXTI1_IRQHandler
    .thumb_set EXTI1_IRQHandler, Default_Handler
    .weak      EXTI2_IRQHandler
    .thumb_set EXTI2_IRQHandler, Default_Handler
    .weak      EXTI3_IRQHandler
    .thumb_set EXTI3_IRQHandler, Default_Handler
    .weak      EXTI4_IRQHandler
    .thumb_set EXTI4_IRQHandler, Default_Handler
    .weak      DMA1_Stream0_IRQHandler
    .thumb_set DMA1_Stream0_IRQHandler, Default_Handler
    .weak      DMA1_Stream1_IRQHandler
    .thumb_set DMA1_Stream1_IRQHandler, Default_Handler
    .weak      DMA1_Stream2_IRQHandler
    .thumb_set DMA1_Stream2_IRQHandler, Default_Handler
    .weak      DMA1_Stream3_IRQHandler
    .thumb_set DMA1_Stream3_IRQHandler, Default_Handler
    .weak      DMA1_Stream4_IRQHandler
    .thumb_set DMA1_Stream4_IRQHandler, Default_Handler
    .weak      DMA1_Stream5_IRQHandler
    .thumb_set DMA1_Stream5_IRQHandler, Default_Handler
    .weak      DMA1_Stream6_IRQHandler
    .thumb_set DMA1_Stream6_IRQHandler, Default_Handler
    .weak      ADC_IRQHandler
    .thumb_set ADC_IRQHandler, Default_Handler
    .weak      FDCAN1_IT0_IRQHandler
    .thumb_set FDCAN1_IT0_IRQHandler, Default_Handler
    .weak      FDCAN2_IT0_IRQHandler
    .thumb_set FDCAN2_IT0_IRQHandler, Default_Handler
    .weak      FDCAN1_IT1_IRQHandler
    .thumb_set FDCAN1_IT1_IRQHandler, Default_Handler
    .weak      FDCAN2_IT1_IRQHandler
    .thumb_set FDCAN2_IT1_IRQHandler, Default_Handler
    .weak      EXTI9_5_IRQHandler
    .thumb_set EXTI9_5_IRQHandler, Default_Handler
    .weak      TIM1_BRK_IRQHandler
    .thumb_set TIM1_BRK_IRQHandler, Default_Handler
    .weak      TIM1_UP_IRQHandler
    .thumb_set TIM1_UP_IRQHandler, Default_Handler
    .weak      TIM1_TRG_COM_IRQHandler
    .thumb_set TIM1_TRG_COM_IRQHandler, Default_Handler
    .weak      TIM1_CC_IRQHandler
    .thumb_set TIM1_CC_IRQHandler, Default_Handler
    .weak      TIM2_IRQHandler
    .thumb_set TIM2_IRQHandler, Default_Handler
    .weak      TIM3_IRQHandler
    .thumb_set TIM3_IRQHandler, Default_Handler
    .weak      TIM4_IRQHandler
    .thumb_set TIM4_IRQHandler, Default_Handler
    .weak      I2C1_EV_IRQHandler
    .thumb_set I2C1_EV_IRQHandler, Default_Handler
    .weak      I2C1_ER_IRQHandler
    .thumb_set I2C1_ER_IRQHandler, Default_Handler
    .weak      I2C2_EV_IRQHandler
    .thumb_set I2C2_EV_IRQHandler, Default_Handler
    .weak      I2C2_ER_IRQHandler
    .thumb_set I2C2_ER_IRQHandler, Default_Handler
    .weak      SPI1_IRQHandler
    .thumb_set SPI1_IRQHandler, Default_Handler
    .weak      SPI2_IRQHandler
    .thumb_set SPI2_IRQHandler, Default_Handler
    .weak      USART1_IRQHandler
    .thumb_set USART1_IRQHandler, Default_Handler
    .weak      USART2_IRQHandler
    .thumb_set USART2_IRQHandler, Default_Handler
    .weak      USART3_IRQHandler
    .thumb_set USART3_IRQHandler, Default_Handler
    .weak      EXTI15_10_IRQHandler
    .thumb_set EXTI15_10_IRQHandler, Default_Handler
    .weak      RTC_Alarm_IRQHandler
    .thumb_set RTC_Alarm_IRQHandler, Default_Handler
    .weak      TIM8_BRK_TIM12_IRQHandler
    .thumb_set TIM8_BRK_TIM12_IRQHandler, Default_Handler
    .weak      TIM8_UP_TIM13_IRQHandler
    .thumb_set TIM8_UP_TIM13_IRQHandler, Default_Handler
    .weak      TIM8_TRG_COM_TIM14_IRQHandler
    .thumb_set TIM8_TRG_COM_TIM14_IRQHandler, Default_Handler
    .weak      TIM8_CC_IRQHandler
    .thumb_set TIM8_CC_IRQHandler, Default_Handler
    .weak      DMA1_Stream7_IRQHandler
    .thumb_set DMA1_Stream7_IRQHandler, Default_Handler
    .weak      FMC_IRQHandler
    .thumb_set FMC_IRQHandler, Default_Handler
    .weak      SDMMC1_IRQHandler
    .thumb_set SDMMC1_IRQHandler, Default_Handler
    .weak      TIM5_IRQHandler
    .thumb_set TIM5_IRQHandler, Default_Handler
    .weak      SPI3_IRQHandler
    .thumb_set SPI3_IRQHandler, Default_Handler
    .weak      UART4_IRQHandler
    .thumb_set UART4_IRQHandler, Default_Handler
    .weak      UART5_IRQHandler
    .thumb_set UART5_IRQHandler, Default_Handler
    .weak      TIM6_DAC_IRQHandler
    .thumb_set TIM6_DAC_IRQHandler, Default_Handler
    .weak      TIM7_IRQHandler
    .thumb_set TIM7_IRQHandler, Default_Handler
    .weak      DMA2_Stream0_IRQHandler
    .thumb_set DMA2_Stream0_IRQHandler, Default_Handler
    .weak      DMA2_Stream1_IRQHandler
    .thumb_set DMA2_Stream1_IRQHandler, Default_Handler
    .weak      DMA2_Stream2_IRQHandler
    .thumb_set DMA2_Stream2_IRQHandler, Default_Handler
    .weak      DMA2_Stream3_IRQHandler
    .thumb_set DMA2_Stream3_IRQHandler, Default_Handler
    .weak      DMA2_Stream4_IRQHandler
    .thumb_set DMA2_Stream4_IRQHandler, Default_Handler
    .weak      ETH_IRQHandler
    .thumb_set ETH_IRQHandler, Default_Handler
    .weak      ETH_WKUP_IRQHandler
    .thumb_set ETH_WKUP_IRQHandler, Default_Handler
    .weak      FDCAN_CAL_IRQHandler
    .thumb_set FDCAN_CAL_IRQHandler, Default_Handler
    .weak      DMA2_Stream5_IRQHandler
    .thumb_set DMA2_Stream5_IRQHandler, Default_Handler
    .weak      DMA2_Stream6_IRQHandler
    .thumb_set DMA2_Stream6_IRQHandler, Default_Handler
    .weak      DMA2_Stream7_IRQHandler
    .thumb_set DMA2_Stream7_IRQHandler, Default_Handler
    .weak      USART6_IRQHandler
    .thumb_set USART6_IRQHandler, Default_Handler
    .weak      I2C3_EV_IRQHandler
    .thumb_set I2C3_EV_IRQHandler, Default_Handler
    .weak      I2C3_ER_IRQHandler
    .thumb_set I2C3_ER_IRQHandler, Default_Handler
    .weak      OTG_HS_EP1_OUT_IRQHandler
    .thumb_set OTG_HS_EP1_OUT_IRQHandler, Default_Handler
    .weak      OTG_HS_EP1_IN_IRQHandler
    .thumb_set OTG_HS_EP1_IN_IRQHandler, Default_Handler
    .weak      OTG_HS_WKUP_IRQHandler
    .thumb_set OTG_HS_WKUP_IRQHandler, Default_Handler
    .weak      OTG_HS_IRQHandler
    .thumb_set OTG_HS_IRQHandler, Default_Handler
    .weak      DCMI_IRQHandler
    .thumb_set DCMI_IRQHandler, Default_Handler
    .weak      RNG_IRQHandler
    .thumb_set RNG_IRQHandler, Default_Handler
    .weak      FPU_IRQHandler
    .thumb_set FPU_IRQHandler, Default_Handler
    .weak      UART7_IRQHandler
    .thumb_set UART7_IRQHandler, Default_Handler
    .weak      UART8_IRQHandler
    .thumb_set UART8_IRQHandler, Default_Handler
    .weak      SPI4_IRQHandler
    .thumb_set SPI4_IRQHandler, Default_Handler
    .weak      SPI5_IRQHandler
    .thumb_set SPI5_IRQHandler, Default_Handler
    .weak      SPI6_IRQHandler
    .thumb_set SPI6_IRQHandler, Default_Handler
    .weak      SAI1_IRQHandler
    .thumb_set SAI1_IRQHandler, Default_Handler
    .weak      LTDC_IRQHandler
    .thumb_set LTDC_IRQHandler, Default_Handler
    .weak      LTDC_ER_IRQHandler
    .thumb_set LTDC_ER_IRQHandler, Default_Handler
    .weak      DMA2D_IRQHandler
    .thumb_set DMA2D_IRQHandler, Default_Handler
    .weak      SAI2_IRQHandler
    .thumb_set SAI2_IRQHandler, Default_Handler
    .weak      QUADSPI_IRQHandler
    .thumb_set QUADSPI_IRQHandler, Default_Handler
    .weak      LPTIM1_IRQHandler
    .thumb_set LPTIM1_IRQHandler, Default_Handler
    .weak      CEC_IRQHandler
    .thumb_set CEC_IRQHandler, Default_Handler
    .weak      I2C4_EV_IRQHandler
    .thumb_set I2C4_EV_IRQHandler, Default_Handler
    .weak      I2C4_ER_IRQHandler
    .thumb_set I2C4_ER_IRQHandler, Default_Handler
    .weak      SPDIF_RX_IRQHandler
    .thumb_set SPDIF_RX_IRQHandler, Default_Handler
    .weak      OTG_FS_EP1_OUT_IRQHandler
    .thumb_set OTG_FS_EP1_OUT_IRQHandler, Default_Handler
    .weak      OTG_FS_EP1_IN_IRQHandler
    .thumb_set OTG_FS_EP1_IN_IRQHandler, Default_Handler
    .weak      OTG_FS_WKUP_IRQHandler
    .thumb_set OTG_FS_WKUP_IRQHandler, Default_Handler
    .weak      OTG_FS_IRQHandler
    .thumb_set OTG_FS_IRQHandler, Default_Handler
    .weak      DMAMUX1_OVR_IRQHandler
    .thumb_set DMAMUX1_OVR_IRQHandler, Default_Handler
    .weak      HRTIM1_Master_IRQHandler
    .thumb_set HRTIM1_Master_IRQHandler, Default_Handler
    .weak      HRTIM1_TIMA_IRQHandler
    .thumb_set HRTIM1_TIMA_IRQHandler, Default_Handler
    .weak      HRTIM1_TIMB_IRQHandler
    .thumb_set HRTIM1_TIMB_IRQHandler, Default_Handler
    .weak      HRTIM1_TIMC_IRQHandler
    .thumb_set HRTIM1_TIMC_IRQHandler, Default_Handler
    .weak      HRTIM1_TIMD_IRQHandler
    .thumb_set HRTIM1_TIMD_IRQHandler, Default_Handler
    .weak      HRTIM1_TIME_IRQHandler
    .thumb_set HRTIM1_TIME_IRQHandler, Default_Handler
    .weak      HRTIM1_FLT_IRQHandler
    .thumb_set HRTIM1_FLT_IRQHandler, Default_Handler
    .weak      DFSDM1_FLT0_IRQHandler
    .thumb_set DFSDM1_FLT0_IRQHandler, Default_Handler
    .weak      DFSDM1_FLT1_IRQHandler
    .thumb_set DFSDM1_FLT1_IRQHandler, Default_Handler
    .weak      DFSDM1_FLT2_IRQHandler
    .thumb_set DFSDM1_FLT2_IRQHandler, Default_Handler
    .weak      DFSDM1_FLT3_IRQHandler
    .thumb_set DFSDM1_FLT3_IRQHandler, Default_Handler
    .weak      SAI3_IRQHandler
    .thumb_set SAI3_IRQHandler, Default_Handler
    .weak      SWPMI1_IRQHandler
    .thumb_set SWPMI1_IRQHandler, Default_Handler
    .weak      TIM15_IRQHandler
    .thumb_set TIM15_IRQHandler, Default_Handler
    .weak      TIM16_IRQHandler
    .thumb_set TIM16_IRQHandler, Default_Handler
    .weak      TIM17_IRQHandler
    .thumb_set TIM17_IRQHandler, Default_Handler
    .weak      MDIOS_WKUP_IRQHandler
    .thumb_set MDIOS_WKUP_IRQHandler, Default_Handler
    .weak      MDIOS_IRQHandler
    .thumb_set MDIOS_IRQHandler, Default_Handler
    .weak      JPEG_IRQHandler
    .thumb_set JPEG_IRQHandler, Default_Handler
    .weak      MDMA_IRQHandler
    .thumb_set MDMA_IRQHandler, Default_Handler
    .weak      SDMMC2_IRQHandler
    .thumb_set SDMMC2_IRQHandler, Default_Handler
    .weak      HSEM1_IRQHandler
    .thumb_set HSEM1_IRQHandler, Default_Handler
    .weak      ADC3_IRQHandler
    .thumb_set ADC3_IRQHandler, Default_Handler
    .weak      DMAMUX2_OVR_IRQHandler
    .thumb_set DMAMUX2_OVR_IRQHandler, Default_Handler
    .weak      BDMA_Channel0_IRQHandler
    .thumb_set BDMA_Channel0_IRQHandler, Default_Handler
    .weak      BDMA_Channel1_IRQHandler
    .thumb_set BDMA_Channel1_IRQHandler, Default_Handler
    .weak      BDMA_Channel2_IRQHandler
    .thumb_set BDMA_Channel2_IRQHandler, Default_Handler
    .weak      BDMA_Channel3_IRQHandler
    .thumb_set BDMA_Channel3_IRQHandler, Default_Handler
    .weak      BDMA_Channel4_IRQHandler
    .thumb_set BDMA_Channel4_IRQHandler, Default_Handler
    .weak      BDMA_Channel5_IRQHandler
    .thumb_set BDMA_Channel5_IRQHandler, Default_Handler
    .weak      BDMA_Channel6_IRQHandler
    .thumb_set BDMA_Channel6_IRQHandler, Default_Handler
    .weak      BDMA_Channel7_IRQHandler
    .thumb_set BDMA_Channel7_IRQHandler, Default_Handler
    .weak      COMP1_IRQHandler
    .thumb_set COMP1_IRQHandler, Default_Handler
    .weak      LPTIM2_IRQHandler
    .thumb_set LPTIM2_IRQHandler, Default_Handler
    .weak      LPTIM3_IRQHandler
    .thumb_set LPTIM3_IRQHandler, Default_Handler
    .weak      LPTIM4_IRQHandler
    .thumb_set LPTIM4_IRQHandler, Default_Handler
    .weak      LPTIM5_IRQHandler
    .thumb_set LPTIM5_IRQHandler, Default_Handler
    .weak      LPUART1_IRQHandler
    .thumb_set LPUART1_IRQHandler, Default_Handler
    .weak      CRS_IRQHandler
    .thumb_set CRS_IRQHandler, Default_Handler
    .weak      ECC_IRQHandler
    .thumb_set ECC_IRQHandler, Default_Handler
    .weak      SAI4_IRQHandler
    .thumb_set SAI4_IRQHandler, Default_Handler
    .weak      WAKEUP_PIN_IRQHandler
    .thumb_set WAKEUP_PIN_IRQHandler, Default_Handler
