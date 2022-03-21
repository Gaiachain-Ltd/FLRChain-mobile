import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import com.flrchain.style 1.0

Controls.TabButton {
    id: root
    font: Style.tabButtonFont
    palette.windowText: Style.tabButtonLabelActiveColor
    palette.brightText: Style.tabButtonLabelInactiveColor
    palette.window: Style.tabButtonBackgroundActiveColor
    palette.dark: Style.tabButtonBackgroundInactiveColor
    palette.mid: Style.tabButtonBackgroundInactiveColor
}
