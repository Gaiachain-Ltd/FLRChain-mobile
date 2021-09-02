# **App build for Android**
**Requirements:**
*  Qt 5.15.2
*  Qt Creator minumum version 4.11 (tested with 4.12)
*  Android NDK r21
*  Android SDK 26
*  JDK 8
*  Compiler: Android Clang(C++,...,NDK 21)

**Instructions:**
* Project uses mrestapi submodule for communication with API and android_openssl submodule (https://github.com/KDAB/android_openssl/tree/1.1.1k_1.0.2u) for OpenSSL libs, to pull it use: *git submodule update --init* after cloning the repository.

**Licences:**
* OpenSSL - OpenSSL Licence (https://www.openssl.org/source/license.html)
* android_openssl - License (https://github.com/KDAB/android_openssl/blob/master/LICENSE)