# AVR Makefile

## Directory Structure

```
.
├── inc
│   └── lib_file.h
├── makefile
└── src
    ├── main.c
    └── lib_file.c
```

## Operation

```
$ make
avr-gcc -mmcu=atmega644p -Os -Wall -std=c99 -DF_CPU=12000000 -I inc/ -MM src/main.c src/lib_file.c > Makefile.deps
avr-gcc -mmcu=atmega644p -Os -Wall -std=c99 -DF_CPU=12000000 -I inc/   -c -o src/main.o src/main.c
avr-gcc -mmcu=atmega644p -Os -Wall -std=c99 -DF_CPU=12000000 -I inc/   -c -o src/lib_file.o src/lib_file.c
avr-gcc -o main.elf src/main.o src/lib_file.o
avr-objcopy -O ihex main.elf main.hex

$ make fuses 
avrdude -c usbasp -p atmega644p -U lfuse:w:0xff:m -U hfuse:w:0x9c:m -U efuse:w:0xff:m

$ make flash 
avrdude -c usbasp -p atmega644p -U flash:w:main.hex

$ make clean 
rm src/*.o main.elf main.hex Makefile.deps
```
