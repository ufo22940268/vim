LOCAL_PATH:= $(call my-dir)

#Build local static library
include $(CLEAR_VARS)
LOCAL_MODULE    := render_static
LOCAL_CFLAGS    := -Wall
LOCAL_SRC_FILES := gl_util.c math_util.c
LOCAL_LDLIBS    := -llog -lGLESv2
include $(BUILD_STATIC_LIBRARY)

#Build shared library for android apk.
include $(CLEAR_VARS)
LOCAL_MODULE    := render
LOCAL_CFLAGS    := -Wall
LOCAL_SRC_FILES := render.c
LOCAL_LDLIBS    := -llog -lGLESv2
LOCAL_STATIC_LIBRARIES := render_static

include $(BUILD_SHARED_LIBRARY)
