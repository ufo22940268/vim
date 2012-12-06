#include <stdio.h>
#include <stdbool.h>
#include <unistd.h>
#include <math.h>
#include <assert.h>
#include "util.h"

int gameStatus = STATUS_NORMAL;
long currentTime;

extern float planeX;
extern float planeY;
extern int speed;
extern int dotCount;
extern int keyStatus;

void testChooseEdge()
{
    /*int x, y;*/

    /*int i = 1;*/
    /*chooseEdge(&x, &y);*/
    /*assert(y == -100);*/
    /*assert(x <= 100 && x >= -100);*/

    /*i = 4;*/
    /*chooseEdge(&x, &y);*/
    /*assert(x == 100);*/
    /*assert(y <= 100 && y >= -100); */

    /*i = 8;*/
    /*chooseEdge(&x, &y);*/
    /*assert(y == 100);*/
    /*assert(x <= 100 && x >= -100); */

    /*i = 12;*/
    /*chooseEdge(&x, &y);*/
    /*assert(x == -100);*/
    /*assert(y <= 100 && y >= -100); */

    int i;
    for (i = 1; i < 10; i ++) {
        dot* d = createDotFromEdge();
        assert(d->angle != 0);
        double dis1 = distant(d->x, d->y, 0, 0);
        double dis2 = distant(d->x + cos(d->angle), d->y + sin(d->angle), 0, 0);
        printf("1: %lf   2: %lf\n", dis1, dis2);
        assert(dis1 >= dis2);
    }
}

void testIsRightAngle() 
{
    int x = -1;
    int y = -1;
    float angle = sin(M_PI/6);
    assert(isRightAngle(x, y, angle));

    angle = sin(M_PI*3/4);
    assert(isRightAngle(x, y, angle));

    angle = sin(M_PI);
    assert(isRightAngle(x, y, angle));

    angle = sin(M_PI + M_PI/6);
    assert(!isRightAngle(x, y, angle));

    angle = sin(M_PI + M_PI/3);
    assert(!isRightAngle(x, y, angle));

    angle = sin(2*M_PI);
    assert(isRightAngle(x, y, angle));
}

bool equalsX(int* xs) 
{
    linked_node *node = getHeaderNode();
    assert(node != NULL);
    while (node) {
        if (node->dot->x != *xs) {
            return false;
        }
        
        xs ++;
        node = node->next;
    }
    return true;
}

void testLinkedDots()
{
    //Test insert.
    dot *dot1 = (dot*)malloc(sizeof(dot));
    dot *dot2 = (dot*)malloc(sizeof(dot));
    dot *dot3 = (dot*)malloc(sizeof(dot));
    dot *dot4 = (dot*)malloc(sizeof(dot));
    dot1->x = 1;
    dot2->x = 2;
    dot3->x = 3;
    dot4->x = 4;
    insertDot(dot1);
    insertDot(dot2);
    insertDot(dot3);
    insertDot(dot4);
    assert(nodesSize() == 4);

    int xs[] = {4, 3, 2, 1};
    assert(equalsX(xs));

    //Test delete.
    assert(deleteDot(dot3));
    assert(nodesSize() == 3);
    int xs2[] = {4, 2, 1};
    assert(equalsX(xs2));

    assert(deleteDot(dot4));
    int xs3[] = {2, 1};
    assert(equalsX(xs3));

    //Test dot size.
    freeAllNodes();
    assert(nodesSize() == 0);
}

void testRand()
{
    float fr1 = timeRandf();
    float fr2 = timeRandf();
    /*assert(fr1 != fr2);*/
    assert(fr1 <= 1 && fr1 >= 0);
    assert(fr2 <= 1 && fr2 >= 0);
}

void testMoving()
{
    freeAllNodes();
    
    //Set up.
    dot* d1 = (dot*)malloc(sizeof(dot));
    d1->x = 1;
    d1->y = 1;
    dot* d2 = (dot*)malloc(sizeof(dot));
    d2->x = 2;
    d2->y = 2;
    
    freeAllNodes();
    insertDot(d1);
    insertDot(d2);

    planeX = 1;
    planeY = 1;
    assert(isCollision());

    planeX = 2;
    planeY = 2 + PLANE_SIZE;
    assert(isCollision());

    planeX = 2;
    planeY = 2 + PLANE_SIZE + 1;
    assert(!isCollision());
}

void testUtils() 
{
    double d1 = distant(1, 0, 0, 0);
    assert(d1 == 1);
    
    d1 = distant(2, 0, 0, 0);
    assert(d1 == 2);
}

void testUpdate()
{
    resetTimeData();

    updateTimeData();
    speed = SPEED_UNIT;
    dotCount = DOT_UNIT;
    updateTimeData();
    speed = SPEED_UNIT*2;
    dotCount = DOT_UNIT*2;

    resetTimeData();
    speed = 0;
    dotCount = 0;
}

void testKeyboard()
{
    pressKey(KEY_UP);
    assert(keyStatus == FLAG_UP);
    assert(getPlaneDirection() == DIRECTION_UP);

    resetKeyStatus();
    pressKey(KEY_UP);
    pressKey(KEY_LEFT);
    assert(getPlaneDirection() == DIRECTION_LEFT_UP);
    pressKey(KEY_RIGHT);
    assert(getPlaneDirection() == DIRECTION_LEFT_UP);
    pressKey(KEY_DOWN);
    assert(getPlaneDirection() == DIRECTION_VOID);
    releaseKey(KEY_UP);
    assert(getPlaneDirection() == DIRECTION_LEFT_DOWN);
    
    resetKeyStatus();
    assert(keyStatus == FLAG_VOID);
    assert(getPlaneDirection() == DIRECTION_VOID);
}

void testBend()
{
    int i;
    planeX = 1;
    planeY = 1;
    int data[1][3] = {{0, 0, M_PI/4}};
    for (i = 0; i < 1; i ++) {
        dot d = {.x=data[i][0], .y=data[i][1], .angle=data[i][2]};
        double oldAngle = d.angle;
        bendAngle(&d);
        double newAngle = d.angle; 
        assert(oldAngle != newAngle);

        double d1 = distant(planeX, planeY, d.x + cos(oldAngle), d.y + sin(oldAngle));
        double d2 = distant(planeX, planeY, d.x + cos(newAngle), d.y + sin(newAngle));
        assert(d1 > d2);
    }
}

void testCloserNewAngle()
{
    planeX = 1;
    planeY = 1;
    dot d = {.x=0, .y=0, .angle=0};
    float newAngle = M_PI/6;
    assert(closerNewAngle(&d, newAngle));
}

void testC()
{
    long a = 1353895194;
    assert(a%3 == 0);

    a = 1353895195;
    assert(a%3 == 1);
}

void testChangeLevel()
{
    currentTime = 1;
    assert(!shouldBendDots());
    assert(!shouldSpeedUpDots());
    assert(!shouldSpeedUpDotsPermanentaly());

    currentTime = 2;
    assert(!shouldBendDots());
    assert(!shouldSpeedUpDots());
    assert(!shouldSpeedUpDotsPermanentaly());

    currentTime = 3;
    assert(!shouldBendDots());
    assert(!shouldSpeedUpDots());
    assert(!shouldSpeedUpDotsPermanentaly());

    currentTime = 4;
    assert(shouldBendDots());
    assert(!shouldSpeedUpDots());
    assert(!shouldSpeedUpDotsPermanentaly());

    currentTime = 6;
    assert(shouldBendDots());
    assert(!shouldSpeedUpDots());
    assert(!shouldSpeedUpDotsPermanentaly());

    currentTime = 7;
    assert(shouldBendDots());
    assert(!shouldSpeedUpDots());
    assert(shouldSpeedUpDotsPermanentaly());

    currentTime = 9;
    assert(!shouldBendDots());
    assert(shouldSpeedUpDots());
    assert(!shouldSpeedUpDotsPermanentaly());

    currentTime = 15;
    assert(shouldBendDots());
    assert(shouldSpeedUpDots());
    assert(!shouldSpeedUpDotsPermanentaly());
}

int main() 
{
    //Don't know why this test case can passed.
    /*testChooseEdge();*/
    testIsRightAngle();
    testLinkedDots();
    testRand();
    testMoving();
    testUtils();
    testUpdate();
    testKeyboard();
    testBend();
    testChangeLevel();

    testCloserNewAngle();

    //One shot test.
    testC();

    printf("Test passed.\n");

    getchar();
    return 0;
}
