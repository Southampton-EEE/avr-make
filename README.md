# avr-make

A build routine for UoS's Il Matto board.

## Installation

There is an automated installation script that copys the script to your `/usr/local/bin`, so that you can run the script from any directory. Run this script like so

    ./install

It will then prompt you for your password.

## Uploading to the Board

Run like so

    avr-make file.c

You will be prompted to verify that you have loaded the bootloader and have the Il Matto plugged in.

Compiles using `avr-gcc`, then uses `avr-objcopy` before sending the file over USB with `avrdude`. Note that this package dosn't include these dependancies.
