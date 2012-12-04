#ifdef __APPLE__
    #include <GLUT/glut.h>
#else
    #include <GL/glut.h>
#endif

#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include "types.h"

#define SHUFFLE time(NULL)

float toRadians(float degree);
void drawCircle(float r);
void drawPlane();
void movePlane(int x, int y);
void movePlaneInDirection(int key);
void drawDots();
void setDotColor();
void drawString(int x, int y, char* str);
void drawFlyStatusString(char* str);
bool isCollision();

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
