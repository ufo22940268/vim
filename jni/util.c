#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <GLES2/gl2.h>
#include "util.h"

int global_seed = 0;

extern long startTime;

float toRadians(int degree) {
    return M_PI/180*degree;
}

void drawCircle()
{
    glEnableVertexAttribArray(gPosHandler);
    glVertexAttribPointer(gPosHandler, 2, GL_FLOAT, GL_FALSE, 0, gPlaneCoords);
    glDrawArrays(GL_TRIANGLE_FAN, 0, 360);
    glDisableVertexAttribArray(gPosHandler);
}

void drawString(int x, int y, char* str) 
{
    //TODO
    /*glRasterPos2i(x, y);*/

    /*int i;*/
    /*for (i = 0; i < strlen(str); i ++) {*/
        /*glutBitmapCharacter(GLUT_BITMAP_TIMES_ROMAN_24, str[i]);*/
    /*}*/
}

void drawFlyStatusString(char* str) {
    /*drawString(-100, 90, str);*/
}

int timeRand()
{
    srand(time(NULL) * global_seed);
    global_seed = (global_seed + 1)%100000;
    return rand();
}

float timeRandf()
{
    int ri = timeRand();
    return (float)(ri%100)/100;
}

void setColor(int color) 
{
    float r = (float)((color&0xff0000)>>16)/255;
    float g = (float)((color&0x00ff00)>>8)/255; 
    float b = (float)((color&0x0000ff)>>0)/255;
    GLfloat ar[] = {r, g, b, 1};
    glUniform4fv(gColorHandler, 1, ar);
}

double distant(double xa, double ya, double xb, double yb) 
{
    return sqrt(pow(xa - xb, 2) + pow(ya - yb, 2));
}
