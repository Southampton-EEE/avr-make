#--------------------------------------
# Set device, directories and programmer here
#--------------------------------------

# main file
TARGET = main

# directories
SRC = src
INC = inc

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

# source files and object directory
SOURCES = $(wildcard $(SRC)/*.c)
OBJECTS = $(patsubst %.c, %.o, $(SOURCES))

# get file dependencies then build hex
all: Makefile.deps $(TARGET).hex

# include object dependencies
-include Makefile.deps

$(TARGET).elf: $(OBJECTS)
	$(CC) -o $@ $^

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex $< $@

# generate object dependencies
Makefile.deps: $(SOURCES)
	$(CC) $(CFLAGS) -MM $^ > Makefile.deps

# remove build files
clean:
	@rm src/*.o $(TARGET).elf $(TARGET).hex Makefile.deps

# flash to micro-controller
flash: $(TARGET).hex
	$(AVRDUDE) -U flash:w:$<

# set fuses
fuses:
	$(AVRDUDE) -U lfuse:w:$(LFUSE):m -U hfuse:w:$(HFUSE):m -U efuse:w:$(EFUSE):m

# show fuses already set on micro-controller
show_fuses:
	$(AVRDUDE) -nv
