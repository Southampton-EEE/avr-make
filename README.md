# avr-make

A build routine for UoS's Il Matto board.

## Uploading to the Board

run like

    avr-make file.c

Compiles using `avr-gcc`, then uses `avr-objcopy` before sending the file over USB with `avrdude`.
