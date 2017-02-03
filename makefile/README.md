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
Creating...     bin/
Compiling...    bin/lib_file.o
Compiling...    bin/main.o
Linking...      bin/main.elf bin/lib_file.o bin/main.o
Building...     main.hex

$ make fuses 
Set Fuses...    lfuse:0xff hfuse:0x9c efuse:0xff

$ make flash 
Flashing...     atmega644p usbasp 12000000

$ make clean 
Cleaning...     bin/ main.hex
```
