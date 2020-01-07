#
# Copyright (C) 2018 The TwrpBuilder Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/Android/rk3318

TARGET_BOARD_PLATFORM := rk3328
TARGET_BOOTLOADER_BOARD_NAME := rk3318

# Recovery
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true            # To add info about F2FS Filesystem Data Block
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_FLASH_BLOCK_SIZE := 0
BOARD_HAS_NO_REAL_SDCARD := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_RECOVERY_SWIPE := true
BOARD_USES_MMCUTILS := true
BOARD_SUPPRESS_EMMC_WIPE := true


# TWRP stuff
TW_EXCLUDE_SUPERSU := true                     # true/false: Add SuperSU or not
TW_INCLUDE_CRYPTO := true                      # true/false: Add Data Encryption Support or not
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_SCREEN_BLANK_ON_BOOT := true
DEVICE_RESOLUTION := 720x1280                  # The Resolution of your Device
TARGET_SCREEN_HEIGHT := 1280                     # The height
TARGET_SCREEN_WIDTH := 720                       # The width
TARGET_RECOVERY_PIXEL_FORMAT := "RGBA_8888"
# Set the Brightness Control File Path below
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_SECONDARY_BRIGHTNESS_PATH := /sys/devices/platform/leds-mt65xx/leds/lcd-backlight/brightness
# Set the Path of Logical Units (LUNs) for Storage below
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/mt_usb/musb-hdrc.0.auto/gadget/lun%d/file
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/class/android_usb/android0/f_mass_storage/lun/file
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 80                   # Set custom brightness, low is better

TW_INCLUDE_NTFS_3G := true                    # Include NTFS Filesystem Support
TW_INCLUDE_FUSE_EXFAT := true                 # Include Fuse-ExFAT Filesystem Support
TWRP_INCLUDE_LOGCAT := true                   # Include LogCat Binary
TW_INCLUDE_FB2PNG := true                     # Include Screenshot Support
TW_DEFAULT_LANGUAGE := en                     # Set Default Language 
TW_EXTRA_LANGUAGES := false
TW_INCLUDE_CRYPTO := true

# Kernel
TARGET_IS_64_BIT := true                      # true/false: Determine if the device is 64-bit or not
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel
# Get the CMDLine, Base, Pagesize and offsets from Unpacked recovery image and put below
#BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE := console=ttyFIQ0 androidboot.baseband=N/A androidboot.selinux=permissive androidboot.wificountrycode=US androidboot.veritymode=enforcing androidboot.hardware=rk30board androidboot.console=ttyFIQ0 firmware_class.path=/vendor/etc/firmware init=/init rootwait ro init=/init root=PARTUUID=af01642c-9b84-11e8-9b2a-234eb5e198a0 loop.max_part=7 buildvariant=userdebug
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01000000 --tags_offset 0x00000100 --dt $(LOCAL_PATH)/dt.img

TARGET_BOARD_SUFFIX := _64                    # Remove if the device is 32-bit
TARGET_USES_64_BIT_BINDER := true             # Remove if the device is 32-bit

# Check whether the device is 64-bit or 32-bit, and then include the TWRPBuilder Part
ifeq ($(TARGET_IS_64_BIT),true)
include device/generic/twrpbuilder/BoardConfig64.mk   # If the device Is 64-bit, it'll be used
else
include device/generic/twrpbuilder/BoardConfig32.mk   # If the device Is 32-bit, it'll be used
endif
