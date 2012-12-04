#include "util.h"

int keyStatus;

int directionSequences[8][2] = {
    {FLAG_LEFT  | FLAG_UP   , DIRECTION_LEFT_UP},
    {FLAG_RIGHT | FLAG_UP   , DIRECTION_RIGHT_UP},
    {FLAG_LEFT  | FLAG_DOWN , DIRECTION_LEFT_DOWN},
    {FLAG_RIGHT | FLAG_DOWN , DIRECTION_RIGHT_DOWN},
    {FLAG_LEFT              , DIRECTION_LEFT},
    {FLAG_UP                , DIRECTION_UP},
    {FLAG_RIGHT             , DIRECTION_RIGHT},
    {FLAG_DOWN              , DIRECTION_DOWN},
};


int getKeyFlag(char key) 
{
    switch (key) {
        case KEY_UP:
            return FLAG_UP;
        case KEY_DOWN:
            return FLAG_DOWN;
        case KEY_LEFT:
            return FLAG_LEFT;
        case KEY_RIGHT:
            return FLAG_RIGHT;
    }
    return FLAG_VOID;
}

int getSingleDirection(int status)
{
    switch (status) {
        case FLAG_LEFT:
            return DIRECTION_LEFT;
        case FLAG_UP:
            return DIRECTION_UP;
        case FLAG_RIGHT:
            return DIRECTION_RIGHT;
        case FLAG_DOWN:
            return DIRECTION_DOWN;
    }

    return DIRECTION_VOID;
}

bool isControllerKey(char key) 
{
    if (key == KEY_UP || key == KEY_DOWN || key == KEY_LEFT || key == KEY_RIGHT) {
        return true;
    } else {
        return false;
    }
}

void controlPlane(char key) 
{
    pressKey(key);
}

void pressKey(char key) 
{
    keyStatus |= getKeyFlag(key);
}

void releaseKey(char key) 
{
    int flag = getKeyFlag(key);

    //Check if the key was pressed before.
    //If the key wasn't pressed before, then just return.
    if ((flag&keyStatus) == 0) {
        return;
    }

    keyStatus = flag^keyStatus;
}

void resetKeyStatus()
{
    keyStatus = FLAG_VOID;
}

int getPlaneDirection()
{
    //Check void status.
    if (keyStatus == FLAG_VOID || keyStatus == (FLAG_LEFT|FLAG_RIGHT) || keyStatus == (FLAG_UP|FLAG_DOWN) || keyStatus == (FLAG_LEFT|FLAG_UP|FLAG_RIGHT|FLAG_DOWN)) {
        return DIRECTION_VOID;
    }

    //Eval direction with the pority defined in directionSequences.
    int i;
    for (i = 0; i < 8; i ++) {
        if ((keyStatus&directionSequences[i][0]) == directionSequences[i][0]) {
            return directionSequences[i][1];
        }
    }

    return DIRECTION_VOID;
}

void controlPlaneRelease(char key) 
{
    releaseKey(key);
}
