all:
	#ndk-build && ant debug install&&adb shell "am start -n opengl.demo/.MainActivity"; sleep 2 && adb shell "pkill opengl.demo"
	ndk-build && ant debug install&&adb shell "am start -n opengl.demo/.MainActivity";
