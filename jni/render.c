#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <pthread.h>
#include <unistd.h>
#include <pthread.h>

#include "util.h"

//TODO implement thess vars.
int updateCount;
int gameStatus = STATUS_NORMAL;
long startTime;
long lastingTime = -1;
long currentTime;

extern int flyStatus;

pthread_mutex_t gNodeLock;

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
    GLfloat size = PLANE_SIZE;
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
startTimer() {
    /*pthread_t *viewThread = (pthread_t*)malloc(sizeof(pthread_t));*/
    /*pthread_t *dataThread = (pthread_t*)malloc(sizeof(pthread_t));*/
    /*pthread_t *bendThread = (pthread_t*)malloc(sizeof(pthread_t));*/
    /*pthread_t *moveThread = (pthread_t*)malloc(sizeof(pthread_t));*/

    /*pthread_create(viewThread, NULL, viewTimer, NULL);*/
    /*pthread_create(dataThread, NULL, dataTimer, NULL);*/
    /*pthread_create(bendThread, NULL, bendAngleTimer, NULL);*/
    /*pthread_create(moveThread, NULL, moveTimer, NULL);*/

    pthread_t *allThread = (pthread_t*)malloc(sizeof(pthread_t));
    pthread_create(allThread, NULL, allTimer, NULL);

    startTime = time(NULL);
}

void
initLocks() {
    pthread_mutex_init(&gNodeLock, NULL);
}

//TODO It should been called when program exits.
void
destroyLocks() {
    pthread_mutex_destroy(&gNodeLock);
}


void
Java_opengl_demo_NativeRenderer_init(JNIEnv *env, jobject thiz) {
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);

    initLocks();
    loadSource();
    initPlaneCoords();

    gProjectionHandler = glGetUniformLocation(gProgram, "uMVPMatrix");
    gColorHandler = glGetUniformLocation(gProgram, "vColor");
    gPosHandler = glGetAttribLocation(gProgram, "vPosition");
    gSizeHandler = glGetAttribLocation(gProgram, "vPointSize");
    gOrthoHandler = glGetUniformLocation(gProgram, "uOthoMatrix");
    checkGlError("3");

    startTimer();
}

void
Java_opengl_demo_NativeRenderer_change(JNIEnv *env, jobject thiz, int width, int height) {
    glViewport(0, 0, width, height);
    sWindowWidth = width;
    sWindowHeight = height;
    debugError("4");
}

void
*test_print() {
    while (1) {
        useconds_t msec = 1000*1000;
        usleep(msec);
    }
}

//TODO
void finishGame() 
{
    gameStatus = STATUS_FINISHED;

    if (lastingTime == -1) {
        lastingTime = time(NULL) - startTime;
    }
}

void resetGame() 
{
    resetKeyStatus();
    resetTimeData();
    freeAllNodes();

    startTime = time(NULL);
    lastingTime = -1;
    gameStatus = STATUS_NORMAL;
    flyStatus = FLY_VOID;
}

void
Java_opengl_demo_NativeRenderer_test(JNIEnv *env, jobject thiz) {
    /*pthread_t *thread = (pthread_t*)malloc(sizeof(pthread_t));*/
    /*pthread_create(thread, NULL, test_print, NULL);*/
}

void
Java_opengl_demo_NativeRenderer_step(JNIEnv *env, jobject thiz) {
    lockNode();

    glUseProgram(gProgram);

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    loadScreenProjection(gOrthoHandler);

    drawPlane();
    checkGlError("plane");

    drawDots();
    checkGlError("dot");

    unlockNode();
}

void
Java_opengl_demo_MainActivity_resetGame(JNIEnv *env, jobject thiz) {
    resetGame();
}
