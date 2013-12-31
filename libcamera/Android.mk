LOCAL_PATH := $(call my-dir)

ifneq ($(TARGET_QCOM_DISPLAY_VARIANT),)
    DISPLAY := display-$(TARGET_QCOM_DISPLAY_VARIANT)
else
    DISPLAY := display
endif

include $(CLEAR_VARS)

LOCAL_C_FLAGS          += -O3
LOCAL_MODULE_TAGS      := optional
LOCAL_MODULE_PATH      := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE           := camera.$(TARGET_BOARD_PLATFORM)

LOCAL_SRC_FILES        := QcomCamera.cpp

LOCAL_SHARED_LIBRARIES := liblog libdl libutils libcamera_client libbinder \
                          libcutils libhardware libui libcamera

LOCAL_C_INCLUDES       := frameworks/base/services \
                          frameworks/base/include \
                          hardware/libhardware/include

LOCAL_C_INCLUDES       += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_CFLAGS           := -DPREVIEW_MSM7K
LOCAL_C_INCLUDES       += hardware/qcom/$(DISPLAY)/libgralloc

LOCAL_PRELINK_MODULE   := false

ifneq (,$(filter beni cooper,$(CM_BUILD)))
    LOCAL_CFLAGS       += -DBOARD_CAMERA_5MP
endif

include $(BUILD_SHARED_LIBRARY)
