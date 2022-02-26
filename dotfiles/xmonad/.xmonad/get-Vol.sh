#!/bin/bash

amixer | grep "Front Left" | tail -n 1 | cut -d [ -f 2 | cut -d ] -f 1
