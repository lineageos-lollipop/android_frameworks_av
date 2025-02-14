LOCAL_PATH:= $(call my-dir)

ifneq ($(BOARD_USE_CUSTOM_MEDIASERVEREXTENSIONS),true)
include $(CLEAR_VARS)
LOCAL_SRC_FILES := register.cpp
LOCAL_MODULE := libregistermsext
LOCAL_MODULE_TAGS := optional
include $(BUILD_STATIC_LIBRARY)
endif

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	main_mediaserver.cpp 

LOCAL_SHARED_LIBRARIES := \
	libaudioflinger \
	libaudiopolicyservice \
	libcamera_metadata\
	libcameraservice \
	libmedialogservice \
	libcutils \
	libnbaio \
	libmedia \
	libmediaplayerservice \
	libutils \
	liblog \
	libbinder \
	libsoundtriggerservice

LOCAL_STATIC_LIBRARIES := \
	libregistermsext

LOCAL_C_INCLUDES := \
    frameworks/av/media/libmediaplayerservice \
    frameworks/av/media/libmedia \
    frameworks/av/services/medialog \
    frameworks/av/services/audioflinger \
    frameworks/av/services/audiopolicy \
    frameworks/av/services/camera/libcameraservice \
    $(call include-path-for, audio-utils) \
    frameworks/av/services/soundtrigger

ifeq ($(strip $(DOLBY_UDC)),true)
LOCAL_C_INCLUDES += \
    $(TOPDIR)vendor/dolby/include
endif

ifeq ($(strip $(AUDIO_FEATURE_ENABLED_LISTEN)),true)
  LOCAL_SHARED_LIBRARIES += liblisten
  LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audio-listen
  LOCAL_CFLAGS += -DAUDIO_LISTEN_ENABLED
endif

ifneq ($(BOARD_NUMBER_OF_CAMERAS),)
    LOCAL_CFLAGS += -DMAX_CAMERAS=$(BOARD_NUMBER_OF_CAMERAS)
endif

LOCAL_MODULE:= mediaserver
LOCAL_32_BIT_ONLY := true

include $(BUILD_EXECUTABLE)
