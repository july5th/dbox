#!/bin/bash
echo -e "Droidbox Docker starting\nWaiting for the emulator to startup..."
mkdir -p /samples/out
/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}' > /samples/out/ip.txt
sleep 1
/opt/android-sdk-linux/tools/emulator64-arm @droidbox -no-window -no-audio -system /opt/DroidBox_4.1.1/images_new/system.img -ramdisk /opt/DroidBox_4.1.1/images_new/ramdisk.img  >> /samples/out/emulator.log &
sleep 1
adb wait-for-device 
adb forward tcp:5900 tcp:5901
/bin/bash
