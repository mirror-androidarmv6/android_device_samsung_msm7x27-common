LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_TAGS := optional
LOCAL_PRELINK_MODULE := false

LOCAL_SRC_FILES := QualcommCameraHardware.cpp
LOCAL_SRC_FILES += cameraHAL.cpp

LOCAL_CFLAGS  := -DDLOPEN_LIBMMCAMERA=1
LOCAL_CFLAGS += -DNUM_PREVIEW_BUFFERS=4

ifeq ($(BOARD_DEBUG_MEMLEAKS),true)
    LOCAL_CFLAGS += -DHEAPTRACKER
endif

LOCAL_C_INCLUDES := $(TOP)/frameworks/base/include
LOCAL_C_INCLUDES += hardware/qcom/display-legacy/libgralloc
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-camera
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-still/jpeg

LOCAL_SHARED_LIBRARIES := libutils libui libcamera_client liblog libcutils
LOCAL_SHARED_LIBRARIES += libbinder libdl libhardware

ifeq ($(BOARD_DEBUG_MEMLEAKS),true)
    LOCAL_SHARED_LIBRARIES += libheaptracker
endif

include $(BUILD_SHARED_LIBRARY)
