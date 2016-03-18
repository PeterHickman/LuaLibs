#!/bin/sh

APP=msleep

gcc -Wall -bundle -undefined dynamic_lookup -o $APP.so $APP.c
mv $APP.so /usr/local/lib/lua/5.1/$APP.so
