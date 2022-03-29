import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import com.flrchain.style 1.0

Controls.BusyIndicator {
    palette.dark: Style.accentColor
    running: visible
}
