# Copyright (C) 2022  Milo Solutions
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

# Provide version number to application
COMMIT = $$system(git rev-parse --short HEAD)

VERSION=0.0.4

android: {
    ANDROID_VERSION_NAME = $$VERSION
    ANDROID_VERSION_CODE = 104
}

HOST_MACHINE = $$[QMAKE_SPEC]
contains (HOST_MACHINE, .*win32.*) {
    BUILD_DATE=$$system(powershell -Command "Get-Date -format yyyy-MM-dd")
} else {
    BUILD_DATE = $$system(date +%Y-%m-%d)
}

APP_VERSION = "$$VERSION"
APP_NAME = "FLRChain"
COMPANY_NAME = "Gaiachain Lab"
COMPANY_DOMAIN = "gaiachainlab.org.uk"

# add defines
DEFINES += AppVersion='"\\\"$$APP_VERSION\\\""'
DEFINES += AppName='"\\\"$$APP_NAME\\\""'
DEFINES += CompanyName='"\\\"COMPANY_NAME\\\""'
DEFINES += CompanyDomain='"\\\"COMPANY_DOMAIN\\\""'
DEFINES += BuildDate=\\\"$$BUILD_DATE\\\"
DEFINES += GitCommit=\\\"$$COMMIT\\\"

# To use VERSION in non-Qt files, use QMAKE_SUBSTITUTES:
# manifest.input = $$PWD/some/template.xml.in
# manifest.output = $$PWD/some/output.xml
# QMAKE_SUBSTITUTES += manifest
