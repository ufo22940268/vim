#include <string.h>
#include "util.h"
#include "time.h"

int updateCount;
int gameStatus = STATUS_NORMAL;
long startTime;
long lastingTime = -1;
long currentTime;

extern int flyStatus;

char reputations[8][256] = {"hongbosb", "shijiesb", "hongxingsb", "laobansb", "feijisb"};

void init(void) 
{
   glClearColor ((float)0.0, (float)0.0, (float)0.0, (float)0.0);
   glShadeModel (GL_FLAT);
}

void drawReputation()
{
    int lv = (currentTime - startTime)/10;
    char *reputation;
    if (lv < 5) {
        reputation = reputations[lv];
    } else {
        reputation = reputations[4];
    }
    drawString(-50, -10, reputation);
}

void drawRecord()
{
    setColor(COLOR_WHITE);

    char str[] = {"Press R to restart"};
    drawString(-50, 10, str);

    char ts[256];
    sprintf(ts, "%ld s", lastingTime);
    drawString(-50, 0, ts);

    drawReputation();
}

void drawDotStatus()
{
    setColor(COLOR_WHITE);

    char speedUp[] = {"Speed up"};
    char bend[] = {"Tracing"};
    char speedUpBend[] = {"Speed up and tracing"};

    if (flyStatus == FLY_VOID) {
        return;
    } else if (flyStatus == (FLY_BEND | FLY_SPEED_UP)) {
        drawFlyStatusString(speedUpBend);
    } else if (flyStatus == FLY_BEND) {
        drawFlyStatusString(bend);
    } else if (flyStatus == FLY_SPEED_UP) {
        drawFlyStatusString(speedUp);
    } else {
        printf("error\n");
    }
}

void display(void)
{
   glClear (GL_COLOR_BUFFER_BIT);
   glColor3f (1.0, 1.0, 1.0);

   drawPlane();
   drawDots();

   if (gameStatus == STATUS_FINISHED) {
       drawRecord();
   } else {
       drawDotStatus();
   }

   glFlush();
}

void reshape (int w, int h)
{
   glViewport (0, 0, (GLsizei) w, (GLsizei) h); 
   glMatrixMode (GL_PROJECTION);
   glLoadIdentity ();
   glOrtho (-100, 100, -100, 100, 1.5, 20.0);
   glMatrixMode (GL_MODELVIEW);
   glLoadIdentity();             /* clear the matrix */
   gluLookAt (0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
}

void keyboard(int key, int x, int y)
{
   if (isControllerKey(key)) {
       controlPlane(key);
   }
}

void keyboardReset(unsigned char key, int x, int y)
{
   switch (key) {
       case 27:
           exit(0);
           break;
       case 'r':
           if (gameStatus == STATUS_FINISHED) {
               resetGame();
           }
           return;
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

void keyboardUp(int key, int x, int y)
{
   if (isControllerKey(key)) {
       controlPlaneRelease(key);
   }
}

void finishGame() 
{
    gameStatus = STATUS_FINISHED;

    if (lastingTime == -1) {
        lastingTime = time(NULL) - startTime;
    }
}

void debug()
{
    if (flyStatus == FLY_VOID) {
        printf("none\n");
    } else if (flyStatus == (FLY_BEND | FLY_SPEED_UP)) {
        printf("speed up and bend angle\n");
    } else if (flyStatus == FLY_BEND) {
        printf("bend\n");
    } else if (flyStatus == FLY_SPEED_UP) {
        printf("speed up\n");
    } else {
        printf("error\n");
    }
}

void viewTimer(int value)
{

    //When collision happens, just stop animation.
    //TODO Display a game report data. such as lasting time, reputation.
    if (isCollision()) {
        finishGame();
    } else {
        updateDots();
    }

    //Update current time.
    currentTime = time(NULL);

    glutPostRedisplay();
    glutTimerFunc(REFRESH_INTERVAL, viewTimer, 0);
}

void dataTimer(int value)
{
    if (gameStatus == STATUS_NORMAL) {
        updateTimeData();
    }

    /*debug();*/
    glutTimerFunc(UPDATE_DATA_INTERVAL, dataTimer, 0);
}

void bendAngleTimer(int value)
{
    //Bend all dots.
    bendAllDots();
    glutTimerFunc(UPDATE_BEND_ANGLE_INTERVAL, bendAngleTimer, 0);
}

void moveTimer(int value) 
{
    if (gameStatus == STATUS_NORMAL) {
        movePlaneInDirection(getPlaneDirection());
    }
    glutTimerFunc(MOVE_INTERVAL, moveTimer, 0);
}

int main(int argc, char** argv)
{
   glutInit(&argc, argv);
   glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
   glutInitWindowSize(WINDOW_WIDTH, WINDOW_HEIGHT); 
   glutInitWindowPosition(100, 100);
   glutCreateWindow(argv[0]);

   init ();

   glutDisplayFunc(display); 
   glutReshapeFunc(reshape);
   glutKeyboardFunc(keyboardReset);
   glutSpecialFunc(keyboard);
   glutSpecialUpFunc(keyboardUp);
   glutIgnoreKeyRepeat(1);

   glutTimerFunc(REFRESH_INTERVAL, viewTimer, 0);
   glutTimerFunc(UPDATE_DATA_INTERVAL, dataTimer, 0);
   glutTimerFunc(UPDATE_BEND_ANGLE_INTERVAL, bendAngleTimer, 0);
   glutTimerFunc(MOVE_INTERVAL, moveTimer, 0);

   startTime = time(NULL);

   glutMainLoop();
   return 0;
}
