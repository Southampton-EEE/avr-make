# avr-make
A build routine for UoS's El Matto board

## Use

run like

  avr-make file.c

Compiles using `avr-gcc`, then uses `avr-objcopy` before sending the file over USB with `avrdude`.
