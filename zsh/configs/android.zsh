# Set Android SDK root and add emulator to $PATH for easy use
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home

export PATH=$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$JAVA_HOME/bin:$PATH
