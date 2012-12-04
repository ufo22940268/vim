#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>

#include "util.h"

//TODO implement thess vars.
int updateCount;
int gameStatus = STATUS_NORMAL;
long startTime;
long lastingTime = -1;
long currentTime;

static const char vertexSource[] = 
    "attribute vec4 vPosition;\n"
    "attribute float vPointSize;\n"
    "uniform mat4 uMVPMatrix;\n"
    "uniform mat4 uOthoMatrix;\n"
    "void main() {\n"
        "gl_Position = vPosition*uMVPMatrix*uOthoMatrix;\n"
        "gl_PointSize = vPointSize;\n"
    "}";

static const char fragmentSource[] =
    "precision mediump float;\n"
    "uniform vec4 vColor;\n"
    "void main() {\n"
    "    gl_FragColor = vColor;\n"
    "}";

GLuint gProgram;

GLfloat triangleCoords[] = {
    0.0f, 50.0f,
    -50.0f, -50.0f,
    50.0f, -50.0f,
};

GLfloat triangleColor[] = {
    1.0f, 0.0f, 0.0f, 1.0f,
};

GLfloat *gPlaneCoords;

GLuint sWindowHeight;
GLuint sWindowWidth;

GLfloat sVirtualHeight;
GLfloat sVirtualWidth;

GLuint gProjectionHandler;
GLuint gColorHandler; 
GLuint gPosHandler; 
GLuint gSizeHandler; 
GLuint gOrthoHandler; 

static void checkGlError(const char* op) {
    GLint error;
    for (error = glGetError(); error; error
            = glGetError()) {
        LOGD("after %s() glError (0x%x)\n", op, error);
    }
}

void debugError(char* str) {
    int error = glGetError();
    if (error != GL_NO_ERROR) {
        LOGD("error: %s\t error code: %x ", str, error);
    }
}

GLuint loadShader(GLenum type, const GLchar* pSource) {
    GLuint shader= glCreateShader(type);
    if (shader) {
        glShaderSource(shader, 1, &pSource, NULL);
        glCompileShader(shader);
        GLint compiled = 0;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
        if (!compiled) {
            GLint infoLen = 0;
            glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &infoLen);
            if (infoLen) {
                char* buf = (char*) malloc(infoLen);
                if (buf) {
                    glGetShaderInfoLog(shader, infoLen, NULL, buf);
                    LOGD("Could not compile shader %d:\n%s\n",
                            type, buf);
                    free(buf);
                }
                glDeleteShader(shader);
                shader = 0;
            }
        }
    }
    return shader;
}

void initPlaneCoords() {
    int count = 360;
    int stride = 2;
    GLfloat size = 30.0f;
    gPlaneCoords = (GLfloat*)malloc(sizeof(GLfloat)*count*stride);
    int i;
    for (i = 0; i < count*stride; i += 2) {
        gPlaneCoords[i] = cos(toRadians(i))*size;
        gPlaneCoords[i + 1] = sin(toRadians(i))*size;
    }
}

void loadSource() {
    gProgram = glCreateProgram();

    GLuint vertexShader = loadShader(GL_VERTEX_SHADER, vertexSource);
    glAttachShader(gProgram, vertexShader);
    GLuint fragmentShader = loadShader(GL_FRAGMENT_SHADER, fragmentSource);
    glAttachShader(gProgram, fragmentShader);

    glLinkProgram(gProgram);
}

void
Java_opengl_demo_NativeRenderer_init(JNIEnv *env, jobject thiz) {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);

    loadSource();
    initPlaneCoords();

    gProjectionHandler = glGetUniformLocation(gProgram, "uMVPMatrix");
    gColorHandler = glGetUniformLocation(gProgram, "vColor");
    gPosHandler = glGetAttribLocation(gProgram, "vPosition");
    gSizeHandler = glGetAttribLocation(gProgram, "vPointSize");
    gOrthoHandler = glGetUniformLocation(gProgram, "uOthoMatrix");
    checkGlError("3");
}

void
Java_opengl_demo_NativeRenderer_change(JNIEnv *env, jobject thiz, int width, int height) {
    glViewport(0, 0, width, height);
    sWindowWidth = width;
    sWindowHeight = height;
    debugError("4");
}

/*void drawDot() {*/
    /*setColor(0xff0000);*/

    /*GLfloat size[] = {10.0f};*/
    /*glEnableVertexAttribArray(gSizeHandler);*/
    /*glEnableVertexAttribArray(gPosHandler);*/

    /*glVertexAttribPointer(gSizeHandler, 1, GL_FLOAT, GL_FALSE, 0, size);*/
    /*GLfloat pointer[] = {1.0f, 1.0f};*/
    /*glVertexAttribPointer(gPosHandler, 2, GL_FLOAT, GL_FALSE, 0, pointer);*/
    /*glDrawArrays(GL_POINTS, 0, 1);*/

    /*glDisableVertexAttribArray(gPosHandler);*/
    /*glDisableVertexAttribArray(gSizeHandler);*/
/*}*/

void
Java_opengl_demo_NativeRenderer_step(JNIEnv *env, jobject thiz) {
    glUseProgram(gProgram);

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    loadScreenProjection(gOrthoHandler);

    setColor(0x00ff00);
    loadIdentity(gProjectionHandler);
    /*loadIdentity(gOrthoHandler);*/
    translate(30, 1);
    drawCircle();
    checkGlError("plane");

    loadIdentity(gProjectionHandler);
    /*translate(-60, 1);*/
    dot d = {.x=-60, .y=1};
    drawDot(&d);
    checkGlError("dot");
}
