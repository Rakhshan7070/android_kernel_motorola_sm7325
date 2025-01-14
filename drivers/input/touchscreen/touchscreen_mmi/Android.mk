DLKM_DIR := motorola/kernel/modules
LOCAL_PATH := $(call my-dir)

ifeq ($(DRM_DYNAMIC_REFRESH_RATE),true)
	KBUILD_OPTIONS += CONFIG_DRM_DYNAMIC_REFRESH_RATE=y
endif

ifeq ($(TOUCHCLASS_MMI_DEBUG_INFO),true)
	KERNEL_CFLAGS += CONFIG_TOUCHCLASS_MMI_DEBUG_INFO=y
endif

ifeq ($(TOUCHCLASS_MMI_GESTURE_POISON_EVENT),true)
	KERNEL_CFLAGS += CONFIG_TOUCHCLASS_MMI_GESTURE_POISON_EVENT=y
endif

ifeq ($(TOUCHCLASS_MMI_MULTIWAY_UPDATE_FW),true)
	KBUILD_OPTIONS += CONFIG_TOUCHCLASS_MMI_MULTIWAY_UPDATE_FW=y
endif

ifeq ($(DRM_PANEL_NOTIFICATIONS),true)
	KBUILD_OPTIONS += CONFIG_DRM_PANEL_NOTIFICATIONS=y
endif

ifeq ($(DRM_PANEL_EVENT_NOTIFICATIONS),true)
	KBUILD_OPTIONS += CONFIG_DRM_PANEL_EVENT_NOTIFICATIONS=y
endif

ifeq ($(TOUCH_PANEL_NOTIFICATIONS),true)
	KBUILD_OPTIONS += CONFIG_TOUCH_PANEL_NOTIFICATIONS=y
endif

ifneq (,$(findstring gki, $(KERNEL_DEFCONFIG)))
	 KERNEL_CFLAGS += CONFIG_TS_KERNEL_USE_GKI=y
endif

ifeq ($(BOARD_USES_DOUBLE_TAP_CTRL),true)
	KBUILD_OPTIONS += CONFIG_BOARD_USES_DOUBLE_TAP_CTRL=y
endif

ifeq ($(call is-board-platform-in-list, pineapple), true)
	KBUILD_OPTIONS += CONFIG_TOUCHSCREEN_DEVICE_VIRTUAL_PATH=y
endif

ifeq ($(TOUCHCLASS_MMI_EARLY_RESET_ON_RESUME),true)
	KBUILD_OPTIONS += CONFIG_TOUCHSCREEN_EARLY_RESET_ON_RESUME=y
endif

include $(CLEAR_VARS)
LOCAL_MODULE := touchscreen_mmi.ko
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(KERNEL_MODULES_OUT)
LOCAL_ADDITIONAL_DEPENDENCIES := $(KERNEL_MODULES_OUT)/sensors_class.ko
LOCAL_ADDITIONAL_DEPENDENCIES += $(KERNEL_MODULES_OUT)/mmi_relay.ko

ifeq ($(DRM_DYNAMIC_REFRESH_RATE),true)
LOCAL_ADDITIONAL_DEPENDENCIES += $(KERNEL_MODULES_OUT)/msm_drm.ko
endif

KBUILD_OPTIONS_GKI += MODULE_KERNEL_VERSION=$(TARGET_KERNEL_VERSION)
KBUILD_OPTIONS_GKI += GKI_OBJ_MODULE_DIR=gki
include $(DLKM_DIR)/AndroidKernelModule.mk
