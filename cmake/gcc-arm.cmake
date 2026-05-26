# Copyright (c) 2026 Silicon Laboratories Inc.
# SPDX-License-Identifier: Apache-2.0

set(CMAKE_SYSTEM_NAME             Generic)
set(CMAKE_SYSTEM_PROCESSOR        arm)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_COMPILER  arm-zephyr-eabi-gcc)
set(CMAKE_AR          arm-zephyr-eabi-ar)
set(CMAKE_RANLIB      arm-zephyr-eabi-ranlib)

set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS        OFF)

set(CMAKE_C_FLAGS_INIT      "-mcpu=${CPU} -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard -ffunction-sections -fdata-sections -fomit-frame-pointer")
set(CMAKE_C_FLAGS_RELEASE   "-Os -DNDEBUG -Wall -Wextra -Werror" CACHE STRING "")
set(CMAKE_C_ARCHIVE_CREATE  "<CMAKE_AR> qcD <TARGET> <LINK_FLAGS> <OBJECTS>")
set(CMAKE_C_ARCHIVE_FINISH  "<CMAKE_RANLIB> -D <TARGET>")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM   NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY   ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE   ONLY)
