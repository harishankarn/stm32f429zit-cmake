#!/bin/bash
PROJECT_NAME="stm32f429zit-cmake"

openocd -f interface/stlink.cfg -f target/stm32f4x.cfg \
  -c "init" \
  -c "reset halt" \
  -c "program build/$PROJECT_NAME.elf verify reset exit"
