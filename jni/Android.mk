LOCAL_PATH:= $(call my-dir)

#Build local static library
include $(CLEAR_VARS)
LOCAL_MODULE    := render_static
LOCAL_CFLAGS    := -Wall
LOCAL_SRC_FILES := gl_util.c util.c dot.c controller.c linked_dots.c plane.c render.c time_data.c
LOCAL_LDLIBS    := -llog -lGLESv2 -lm -lc
include $(BUILD_STATIC_LIBRARY)

#Build shared library for android apk.
include $(CLEAR_VARS)
LOCAL_MODULE    := render
LOCAL_CFLAGS    := -Wall
LOCAL_SRC_FILES := render.c
LOCAL_LDLIBS    := -llog -lGLESv2 -lm -lc
LOCAL_STATIC_LIBRARIES := render_static
include $(BUILD_SHARED_LIBRARY)

##Build tdd.
#include $(CLEAR_VARS)
#LOCAL_MODULE    := render_exec
#LOCAL_CFLAGS    := -Wall -Wshadow
#LOCAL_SRC_FILES := tdd.c
#LOCAL_LDLIBS    := -llog -lGLESv2 -lm -lc
#include $(BUILD_EXECUTABLE)
