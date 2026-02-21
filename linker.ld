/* Linker script for STM32H750XBH6 - Cortex-M7 */

ENTRY(Reset_Handler)

MEMORY
{
    FLASH  (rx)  : ORIGIN = 0x08000000, LENGTH = 128K
    DTCMRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
    AXIRAM  (rwx) : ORIGIN = 0x24000000, LENGTH = 512K
    SRAM1   (rwx) : ORIGIN = 0x30000000, LENGTH = 128K
    SRAM2   (rwx) : ORIGIN = 0x30020000, LENGTH = 128K
    SRAM4   (rwx) : ORIGIN = 0x38000000, LENGTH = 64K
    ITCMRAM (rwx) : ORIGIN = 0x00000000, LENGTH = 64K
}

_stack_size = 0x2000;
_heap_size  = 0x2000;

SECTIONS
{
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
    } >FLASH

    .text :
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)
        *(.glue_7)
        *(.glue_7t)
        KEEP(*(.init))
        KEEP(*(.fini))
        . = ALIGN(4);
        _etext = .;
    } >FLASH

    .ARM.extab :
    {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } >FLASH

    .ARM :
    {
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
    } >FLASH

    _sidata = LOADADDR(.data);

    .data :
    {
        . = ALIGN(4);
        _sdata = .;
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } >DTCMRAM AT> FLASH

    .bss :
    {
        . = ALIGN(4);
        _sbss = .;
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
        __bss_end__ = _ebss;
    } >DTCMRAM

    ._heap :
    {
        . = ALIGN(8);
        _heap_start = .;
        . = . + _heap_size;
        . = ALIGN(8);
        _heap_end = .;
    } >DTCMRAM

    ._stack :
    {
        . = ALIGN(8);
        . = . + _stack_size;
        . = ALIGN(8);
        _estack = .;
    } >DTCMRAM

    /DISCARD/ :
    {
        *(.ARM.attributes)
    }
}
