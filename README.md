# **App build for Android**
**Requirements:**
*  Qt 5.15.2
*  Qt Creator minumum version 4.11 (tested with 4.12)
*  Android NDK r21
*  Android SDK 26
*  JDK 8
*  Compiler: Android Clang(C++,...,NDK 21)

**Instructions:**
* Project uses mrestapi submodule for communication with API, to pull it use: *git submodule update --init* after cloning the repository

* Adding OpenSSL support
    1. Download repository from: https://github.com/KDAB/android_openssl (Alternatively you can Build OpenSSL libraries manually, 
       detailed instructions: https://doc.qt.io/qt-5/android-openssl-support.html )
    2. In flrchain/flrchain.pro change SSL_PATH to the path where the downloaded repository has been unpacked
