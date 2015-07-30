export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
export ANDROID_HOME=/opt/android-sdk-linux
export ANDROID_SDK_HOME=/opt/android-sdk-linux
export PATH=${PATH}:$JAVA_HOME/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
export ROOTPASSWORD=droidbox

python /opt/DroidBox_4.1.1/scripts/droidbox_new.py $1 $2 2>&1 |tee /samples/out/analysis.log
