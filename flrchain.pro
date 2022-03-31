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
CONFIG += tests

TEMPLATE = subdirs

docs {
    message("Updating doxygen file. No compilation will be performed!")
    doxy.input = $$PWD/template.doxyfile.in
    doxy.output = $$PWD/template.doxyfile
    QMAKE_SUBSTITUTES += doxy
} else {
    SUBDIRS += flrchain \

    tests {
        !android {
            CONFIG(debug, debug|release) {
                message("Running test suite")
                SUBDIRS += tests \
            }
        }
    }
}
