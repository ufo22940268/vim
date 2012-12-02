#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <jni.h>
#include <android/log.h>
#include <GLES2/gl2.h>
#include <GLES2/gl2Ext.h>

#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, "renderer", __VA_ARGS__) 

static const char vertexSource[] = 
    "attribute vec4 vPosition;\n"
    "uniform mat4 uMVPMatrix;\n"
    "void main() {\n"
        "gl_Position = vPosition*uMVPMatrix;\n"
    "}";

static const char fragmentSource[] =
    "precision mediump float;\n"
    "uniform vec4 vColor;\n"
    "void main() {\n"
    "    gl_FragColor = vColor;\n"
    "}";

GLuint gProgram;

GLfloat triangleCoord[] = {
    0.0f, 0.5f,
    -0.5f, -0.5f,
    0.5f, -0.5f,
};

GLfloat triangleColor[] = {
    1.0f, 0.0f, 0.0f, 1.0f,
};

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
    checkGlError("3");
}

void
Java_opengl_demo_NativeRenderer_change(JNIEnv *env, jobject thiz, int width, int height) {
    glViewport(0, 0, width, height);
    debugError("4");
}

void
Java_opengl_demo_NativeRenderer_step(JNIEnv *env, jobject thiz) {
    glUseProgram(gProgram);

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);


    /*Set vertex position.*/
    GLuint posHandler = glGetAttribLocation(gProgram, "vPosition");
    glEnableVertexAttribArray(posHandler);
    glVertexAttribPointer(posHandler, 2, GL_FLOAT, GL_FALSE, 0, triangleCoord);

    //Set vertex color.
    GLuint colorHandler = glGetUniformLocation(gProgram, "vColor");
    glUniform4fv(colorHandler, 1, triangleColor);
    checkGlError("color");

    GLuint projectionHandler = glGetUniformLocation(gProgram, "uMVPMatrix");
    /*GLfloat translateMat[16] = {*/
        /*1.0f, 0.0f, 0.0f, 0.5f,*/
        /*0.0f, 1.0f, 0.0f, 0.5f,*/
        /*0.0f, 0.0f, 1.0f, 0.0f,*/
        /*0.0f, 0.0f, 0.0f, 1.0f,*/
    /*};*/

    GLfloat rotateMat[16] = {
        cos(M_PI/2), -sin(M_PI/2), 0.0f, 0.5f,
        sin(M_PI/2), cos(M_PI/2), 0.0f, 0.5f,
        0.0f, 0.0f, 1.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 1.0f,
    };
    glUniformMatrix4fv(projectionHandler, 1, GL_FALSE, rotateMat);
    checkGlError("projection");

    glDrawArrays(GL_TRIANGLES, 0, 3);

    glDisableVertexAttribArray(posHandler);
}
