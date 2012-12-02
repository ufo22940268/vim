package opengl.demo;

import android.app.Activity;
import android.os.Bundle;
import android.opengl.*;

public class MainActivity extends Activity
{
    private GLSurfaceView mGLSurfaceView;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        mGLSurfaceView = new GLSurfaceView(this);
        mGLSurfaceView.setEGLContextClientVersion(2);
        mGLSurfaceView.setRenderer(new NativeRenderer());
        setContentView(mGLSurfaceView);
    }
}
