#!/bin/bash
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg \
  -c "init" \
  -c "reset halt" \
  -c "program build/STM32-cmake-tmp-trial.elf verify reset exit"
