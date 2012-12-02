package opengl.demo;

import android.util.*;
import android.widget.*;
import android.view.*;
import android.content.*;
import android.app.*;
import android.os.*;
import android.database.*;
import android.net.*;
import android.opengl.*;
import android.opengl.*;

import java.util.*;
import java.nio.*;
import javax.microedition.khronos.opengles.*;
import javax.microedition.khronos.egl.*;

public class MyRenderer implements GLSurfaceView.Renderer  {

    @Override
    public void onDrawFrame(GL10 gl) {
        mTriangle.draw();
    }

    @Override
    public void onSurfaceChanged(GL10 gl, int width, int height) {
        GLES20.glViewport(0, 0, width, height);
    }

    @Override
    public void onSurfaceCreated(GL10 gl, EGLConfig config) {
        mTriangle = new Triangle();
    }
    

    static {
        System.loadLibrary("render");
    }

    private class Triangle {
        private final float TRIANGLE_COORDS[] = {
            0.0f, 0.5f,
            -0.5f, -0.5f,
            0.5f, -0.5f,
        };

        private int mProgram;
        private int mVertexShader;
        private int mFragmentShader;
        private FloatBuffer mTriangleBuffer;
        private float mColor[] = {0f, 1f, 0f, 1f};;

        public Triangle() {
            GLES20.glClearColor(1.0f, 1.0f, 1.0f, 1.0f);

            //Init program.
            mProgram = GLES20.glCreateProgram();
            mVertexShader = loadShader(GLES20.GL_VERTEX_SHADER, VERTEX_SOURCE);
            mFragmentShader = loadShader(GLES20.GL_FRAGMENT_SHADER, FRAGMENT_SOURCE);
            GLES20.glAttachShader(mProgram, mVertexShader);
            GLES20.glAttachShader(mProgram, mFragmentShader);
            GLES20.glLinkProgram(mProgram);

            //Init float buffer.
            ByteBuffer byteBuffer = ByteBuffer.allocateDirect(TRIANGLE_COORDS.length*4);
            byteBuffer.order(ByteOrder.nativeOrder());
            mTriangleBuffer = byteBuffer.asFloatBuffer();
            mTriangleBuffer.put(TRIANGLE_COORDS);
            mTriangleBuffer.position(0);
        }

        private void debugError(String str) {
            int error = GLES20.glGetError();
            if (error != GLES20.GL_NO_ERROR) {
                System.out.println("++++++++++++++++++++" + str + "++++++++++++++++++++");
            }
        }

        public void draw() {
            GLES20.glUseProgram(mProgram);
            debugError("1");

            GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT | GLES20.GL_DEPTH_BUFFER_BIT); 
            debugError("2");

            int posHandle = GLES20.glGetAttribLocation(mProgram, "vPosition");
            GLES20.glEnableVertexAttribArray(posHandle);
            debugError("3");
            GLES20.glVertexAttribPointer(posHandle, 2, GLES20.GL_FLOAT, false, 0, mTriangleBuffer);
            debugError("4");

            int colorHandle = GLES20.glGetUniformLocation(mProgram, "vColor");
            GLES20.glUniform4fv(colorHandle, 1, mColor, 0);
            debugError("5");

            GLES20.glDrawArrays(GLES20.GL_TRIANGLES, 0, 3);
            debugError("6");

            GLES20.glDisableVertexAttribArray(posHandle);
            debugError("7");
        }

        private int loadShader(int type, String source) {
            int shader = GLES20.glCreateShader(type);
            GLES20.glShaderSource(shader, source);
            GLES20.glCompileShader(shader);
            return shader;
        }
    }

    private Triangle mTriangle;

    static private final String VERTEX_SOURCE = 
        "attribute vec4 vPosition;" +
        "void main() {" +
        "   gl_Position = vPosition;" +
        "}";

    static private final String FRAGMENT_SOURCE = 
        "precision mediump float;" +
        "uniform vec4 vColor;" +
        "void main() {" +
        "   gl_FragColor = vColor;" +
        "}";
}
