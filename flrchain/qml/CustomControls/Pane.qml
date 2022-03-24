import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15

import com.flrchain.style 1.0

Controls.Pane {
    id: root

    default property alias content: contentColumn.data
    property alias contentSpacing: contentColumn.spacing

    padding: Style.panePadding

    background: ShadowedRectangle {
        color: Style.paneBackgroundColor
        radius: Style.paneBackgroundRadius
        shadowHorizontalOffset: Style.paneShadowHorizontalOffset
        shadowVerticalOffset: Style.paneShadowVerticalOffset
        shadowRadius: Style.paneShadowRadius
        shadowColor: Style.paneShadowColor
    }

    ColumnLayout {
        id: contentColumn
        anchors.fill: parent
    }
}
