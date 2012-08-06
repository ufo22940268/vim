from com.android.monkeyrunner import MonkeyDevice, MonkeyRunner
import re

device = MonkeyRunner.waitForConnection()
out = device.shell("logcat -d -s ActivityManager")
lines = out.split("\n")

cmps = []
for i, line in zip(range(len(lines)), lines):
    if line.find("android.intent.category.LAUNCHER") != -1:
        cmps.append(line)

for cmp in cmps:
    print "package:", "".join(re.findall("cmp=([^/]*)/", cmp)[0])
