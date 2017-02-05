#--------------------------------------
# Set device, directories and programmer here
#--------------------------------------

# main file
TARGET = main

# source files and object directory
SRC = src
INC = inc
BIN = bin

# device parameters
DEVICE     = atmega644p
CLOCK      = 12000000
PROGRAMMER = usbasp
LFUSE      = 0xff
HFUSE      = 0x9c
EFUSE      = 0xff

# compilers
CC      = avr-gcc
OBJCOPY = avr-objcopy
AVRDUDE = avrdude -c $(PROGRAMMER) -p $(DEVICE)
CFLAGS  = -mmcu=$(DEVICE) -Os -Wall -std=c99 -DF_CPU=$(CLOCK) -I $(INC)/

#--------------------------------------
# No need to edit the below code
#--------------------------------------

MAKEFLAGS += --silent

SOURCE = $(wildcard $(SRC)/*.c)
OBJECT = $(patsubst %,$(BIN)/%,$(notdir $(SOURCE:.c=.o)))

all: $(TARGET).hex

$(BIN)/%.o: $(SRC)/%.c
	test -d $(BIN) || mkdir $(BIN)
	@printf "\033[92m%-15s %s\n\033[0m" "Compiling..." "$@"
	$(CC) $(CFLAGS) -c -o $@ $<

$(BIN)/$(TARGET).elf: $(OBJECT)
	@printf "\033[92m%-15s %s %s\n\033[0m" "Linking..." "$@" "$^"
	$(CC) $(CFLAGS) $^ -o $@

$(TARGET).hex: $(BIN)/$(TARGET).elf
	@printf "\033[92m%-15s %s\n\033[0m" "Building..." "$@"
	$(OBJCOPY) -O ihex $< $@

clean:
	@printf "\033[92m%-15s %s\n\033[0m" "Cleaning..." "$(BIN)/ $(TARGET).hex"
	rm -rf $(BIN) $(TARGET).hex

flash: $(TARGET).hex
	@printf "\033[92m%-15s %s\n\033[0m" "Flashing..." "$(DEVICE) $(PROGRAMMER) $(CLOCK)"
	$(AVRDUDE) -U flash:w:$<

fuses:
	@printf "\033[92m%-15s %s\n\033[0m" "Set Fuses..." "lfuse:$(LFUSE) hfuse:$(HFUSE) efuse:$(EFUSE)"
	$(AVRDUDE) -U lfuse:w:$(LFUSE):m -U hfuse:w:$(HFUSE):m -U efuse:w:$(EFUSE):m

show_fuses:
	$(AVRDUDE) -nv
