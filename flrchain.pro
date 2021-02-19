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
