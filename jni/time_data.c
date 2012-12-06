#include <stdio.h>
#include "util.h"

#define INIT_SPEED 2
#define INIT_DOT_COUNT 5

extern int updateCount;
extern long currentTime;
int flyStatus;

int speed = INIT_SPEED;
int dotCount = INIT_DOT_COUNT;

bool dotStatusSpeedUp = false;

/**
 * Every ten second increment dot count.
 *
 * At four second launch bend dots. 
 * At nine second launch speed-up dots.
 * At fourteen launch speed-up bend dots.
 * All these status above lasting four seconds.
 *
 * Every seven second increment dot speed permenentaly.
 */
bool shouldAddDot()
{
    int t = currentTime%DATA_TIME_CYCLE;
    return t%10 == 0;
}

bool shouldBendDots() 
{
    int t = currentTime%DATA_TIME_CYCLE;
    return (t >= 4 && t < 9) || (t >= 14 && t < 19);
}

bool shouldSpeedUpDots() 
{
    int t = currentTime%DATA_TIME_CYCLE;
    return t >= 9 && t < 19;
}

bool shouldSpeedUpDotsPermanentaly() 
{
    int t = currentTime%DATA_TIME_CYCLE;
    return t%7 == 0;
}

void bendAllDots()
{
    if (shouldBendDots()) {
        //set status.
        flyStatus |= FLY_BEND;

        linked_node *cur = getHeaderNode();
        while (cur) {
            dot *d = cur->dot;
            bendAngle(d);
            cur = cur->next;
        }
    } else {
        flyStatus &= (~FLY_BEND);
    }
}

void updateTimeData()
{
    if (shouldSpeedUpDotsPermanentaly()) {
        //Update speed.
        speed += SPEED_UNIT;
    }

    if (shouldSpeedUpDots()) {
        dotStatusSpeedUp = true;
        flyStatus |= FLY_SPEED_UP;
    } else {
        dotStatusSpeedUp = false;
        flyStatus &= (~FLY_SPEED_UP);
    }

    if (shouldAddDot()) {
        /*Update dot count.*/
        dotCount += DOT_UNIT;
    }
}

//TODO Reset other values.
void resetTimeData()
{
    speed = INIT_SPEED;
    dotCount = INIT_DOT_COUNT;
}
