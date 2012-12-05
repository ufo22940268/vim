#include <unistd.h>
#include <time.h>
#include "util.h"

extern int gameStatus;
extern long currentTime;

void
*viewTimer() {
    //When collision happens, just stop animation.
    //TODO Display a game report data. such as lasting time, reputation.
    if (isCollision()) {
        finishGame();
    } else {
        updateDots();
    }

    //Update current time.
    currentTime = time(NULL);

    //TODO It seems that the flush operation isn't necessary to make
    //screen redraw. So in what does this api should be used.
    /*glFlush();*/

    usleep(REFRESH_INTERVAL);
    viewTimer();
    return NULL;
}

void
*dataTimer() {
    if (gameStatus == STATUS_NORMAL) {
        updateTimeData();
    }

    usleep(UPDATE_DATA_INTERVAL);
    dataTimer();
    return NULL;
}

void
*bendAngleTimer() {
    if (gameStatus == STATUS_NORMAL) {
        bendAllDots();
    }

    usleep(UPDATE_BEND_ANGLE_INTERVAL);
    bendAngleTimer();
    return NULL;
}

void
*moveTimer() {
    if (gameStatus == STATUS_NORMAL) {
        movePlaneInDirection(getPlaneDirection());
    }

    usleep(MOVE_INTERVAL);
    moveTimer();
    return NULL;
}
