#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include <jni.h>
#include <android/log.h>
#include <GLES2/gl2.h>

#include "types.h"

#define SHUFFLE time(NULL)

extern int gameStatus;

float toRadians(int degree);
void drawCircle();
void drawPlane();
void movePlane(int x, int y);
void movePlaneInDirection(int key);
void drawDots();
void setDotColor();
void drawString(int x, int y, char* str);
void drawFlyStatusString(char* str);
bool isCollision();
void drawDot(dot *d);

void setColor(int color);

void updateDots();
void chooseEdge(int *x, int *y);

int timeRand();
float timeRandf(); 
double distant(double xa, double ya, double xb, double yb);

void dotToString(dot* d);

linked_node* getHeaderNode();
void insertDot(dot *dot);
bool deleteDot(dot *dot);
int nodesSize();
void freeAllNodes();

dot* createDotFromEdge();
void bendAngle(dot* d);
void bendAllDots();

void resetTimeData();
void updateTimeData();

bool isControllerKey(char key);
void controlPlane(char key);

void resetKeyStatus();
int getPlaneDirection();
void pressKey(char key);
void releaseKey(char key);

void controlPlaneRelease(char key);

void resetGame();

bool closerNewAngle(dot* d, float newAngle);

/**
 * Is the right angle to fly towards to zero point.
 */
bool isRightAngle(int x, int y, float angle);

bool shouldBendDots();
bool shouldSpeedUpDots();
bool shouldSpeedUpDotsPermanentaly();

//----------------------------------------------------------------------------------------------------
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, "renderer", __VA_ARGS__) 

extern GLuint gProjectionHandler;
extern GLuint gColorHandler; 
extern GLuint gPosHandler; 
extern GLfloat *gPlaneCoords;
extern GLuint gSizeHandler; 

extern void loadIdentity(GLuint handle); 
extern void loadScreenProjection(GLuint handle); 
extern void translate(int x, int y);

extern void* viewTimer();
extern void* dataTimer();
extern void* bendAngleTimer();
extern void* moveTimer();
extern void* lowFpsTimer();
extern void* highFpsTimer();

extern void finishGame();

extern void lockNode();
extern void unlockNode();


//
////Test refactored old interface.
//extern void drawCircle();
//e
