# avr-make

A build routine for UoS's Il Matto board.

## Installation

There is an automated installation script that copys the script to your `/usr/local/bin`, so that you can run the script from any directory. Run this script like so

    ./install

It will then prompt you for your password.

## Uploading to the Board

Run like so

    avr-make file1.c file2.c

Before running make sure the Il Matto is plugged in and the bootloader is activated.

Compiles using `avr-gcc`, then uses `avr-objcopy` before sending the file over USB with `avrdude`. Note that this package dosn't include these dependancies.

## Errors

In the latest version when an error is thrown by one of the above packages it is now displayed.