TARGET = firmware

# Directories
SRC_DIR = src
OBJ_DIR = obj
OUT_DIR = out

# Toolchain
CC      = arm-none-eabi-gcc
AS      = arm-none-eabi-gcc
LD      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SIZE    = arm-none-eabi-size

# Sources
C_SRCS   = $(SRC_DIR)/main.c
ASM_SRCS = $(SRC_DIR)/startup.s

# Prevent (.c) intermediate files from being deleted
.SECONDARY: $(C_SRCS)

# Objects
OBJS = $(addprefix $(OBJ_DIR)/, $(notdir $(C_SRCS:.c=.o) $(ASM_SRCS:.s=.o)))

# Flags
CPU     = -mcpu=cortex-m7 -mthumb
FPU     = -mfloat-abi=soft

CFLAGS  = $(CPU) $(FPU) -std=c99 -Wall -Wextra -Os -g
CFLAGS += -ffunction-sections -fdata-sections -fno-common
CFLAGS += -DSTM32H750xx

ASFLAGS = $(CPU) $(FPU) -g

LDFLAGS  = $(CPU) $(FPU) -T linker.ld
LDFLAGS += -Wl,--gc-sections -nostdlib -nostartfiles
LDFLAGS += -Wl,-Map=$(OUT_DIR)/$(TARGET).map

# Rules
all: $(OUT_DIR)/$(TARGET).bin $(OUT_DIR)/$(TARGET).hex
	$(SIZE) $(OUT_DIR)/$(TARGET).elf

$(OUT_DIR)/$(TARGET).elf: $(OBJS) | $(OUT_DIR)
	$(LD) $(LDFLAGS) -o $@ $^

$(OUT_DIR)/$(TARGET).bin: $(OUT_DIR)/$(TARGET).elf
	$(OBJCOPY) -O binary $< $@

$(OUT_DIR)/$(TARGET).hex: $(OUT_DIR)/$(TARGET).elf
	$(OBJCOPY) -O ihex $< $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	$(AS) $(ASFLAGS) -c -o $@ $<


$(OBJ_DIR) $(OUT_DIR):
	mkdir -p $@

clean:
	echo "Cleaned build artifacts."
	rm -rf $(OBJ_DIR) $(OUT_DIR)


flash: $(OUT_DIR)/$(TARGET).bin
	st-flash --connect-under-reset write $< 0x08000000

.PHONY: all clean flash

