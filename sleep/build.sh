#!/bin/sh

gcc -Wall -bundle -undefined dynamic_lookup -o msleep.so msleep.c
mv msleep.so /usr/local/lib/lua/5.1/msleep.so