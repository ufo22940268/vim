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

import java.util.*;

public class MyGLSurfaceView extends GLSurfaceView {
    public MyGLSurfaceView(Context context, AttributeSet attr) {
        super(context, attr);
        setEGLContextClientVersion(2);
        setRenderer(new NativeRenderer());
    }

    @Override
    public boolean onKeyDown(int keycode, KeyEvent event) {
        System.out.println("++++++++++++++++++++" + keycode + "++++++++++++++++++++");
        return true;
    }
}
