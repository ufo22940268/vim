#include <GLES2/gl2.h>
#include <assert.h>

extern GLuint sWindowWidth;
extern GLuint sWindowHeight;
extern GLfloat sVirtualWidth;
extern GLfloat sVirtualHeight;
extern GLuint gProjectionHandler;
extern GLuint gOrthoHandler;

void 
loadIdentity(GLuint handle) {
    GLfloat identity[16] = {
        1.0f, 0.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f, 0.0f,
        0.0f, 0.0f, 1.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 1.0f,
    };
    glUniformMatrix4fv(handle, 1, GL_FALSE, identity);
}

void 
loadScreenProjection() {
    GLfloat ratio = (GLfloat)sWindowHeight/sWindowWidth;
    assert(ratio != 0);

    GLfloat left   = -100.0f;
    GLfloat right  = 100.0f;
    GLfloat bottom = -100.0f*ratio;
    GLfloat top    = 100.0f*ratio;
    GLfloat identity[16] = {
        2/(right - left) , 0.0f             , 0.0f , (right + left)/(right - left) ,
        0.0f             , 2/(top - bottom) , 0.0f , (top + bottom)/(top - bottom)     ,
        0.0f             , 0.0f             , 1.0f , 0.0f                          ,
        0.0f             , 0.0f             , 0.0f , 1.0f                          ,
    };
    glUniformMatrix4fv(gOrthoHandler, 1, GL_FALSE, identity);

    sVirtualWidth = right;
    sVirtualHeight = top;
}

void
translate(int x, int y) {
    GLfloat translateMat[16] = {
        1.0f, 0.0f, 0.0f, x,
        0.0f, 1.0f, 0.0f, y,
        0.0f, 0.0f, 1.0f, 0.0f,
        0.0f, 0.0f, 0.0f, 1.0f,
    };
    glUniformMatrix4fv(gProjectionHandler, 1, GL_FALSE, translateMat);
}
