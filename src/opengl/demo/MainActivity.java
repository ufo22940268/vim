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
        setContentView(R.layout.main);
    }
}
