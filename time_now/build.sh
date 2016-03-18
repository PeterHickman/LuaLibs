#!/bin/sh

gcc -Wall -bundle -undefined dynamic_lookup -o time_now.so time_now.c
mv time_now.so /usr/local/lib/lua/5.1/time_now.so