pragma Singleton

import QtQuick 2.15

QtObject {

    readonly property string appFontFamily: "Open Sans"
    readonly property font defaultFont: Qt.font({
        family: appFontFamily,
        styleName: "Regular",
        pixelSize: 14
    })

    // Colors
    readonly property color accentColor: "#23BC3D"
    readonly property color bgColor: "#FFFFFF"
    readonly property color shadowedBgColor: "#FAFAFD"
    readonly property color baseLabelColor: "#778699"
    readonly property color grayBgColor: "#E2E9F0"
    readonly property color colorTransparent: "#00ffffff"
    readonly property color darkLabelColor: "#253F50"
    readonly property color inputBgColor: "#F7F9FB"
    readonly property color placeholderColor: "#C0C7D4"
    readonly property color mediumLabelColor: "#72809D"
    readonly property color buttonSecColor: "#06BCC1"
    readonly property color yellowDelegateColor: "#FFFCE2"
    readonly property color yellowLabelColor: "#FFC423"
    readonly property color errorColor: "#FE2121"
    readonly property color sectionColor: "#EDEEF2"
    readonly property color grayLabelColor: "#606060"

    // Fonts
    readonly property int fontMicro: 10
    readonly property int fontTiny: 12
    readonly property int fontSmall: 14
    readonly property int fontMedium: 15
    readonly property int fontBig: 17
    readonly property int fontLarge: 20
    readonly property int fontUltra: 22
    readonly property int fontMax: 29

    // Margins
    readonly property int microMargin: 5
    readonly property int tinyMargin: 10
    readonly property int smallMargin: 16
    readonly property int baseMargin: 20
    readonly property int bigMargin: 30
    readonly property int ultraMargin: 40

    // Icons
    readonly property int iconSize: 18
    readonly property int iconMedium: 21
    readonly property int iconBig: 26
    readonly property int iconUltra: 32

    // Buttons
    readonly property int buttonHeight: 42
    readonly property int iconButtonHeight: 40
    readonly property int menuButtonHeight: 58
    readonly property int checkboxHeight: 16

    // Inputs
    readonly property int textInputHeight: 36
    readonly property int bigInputHeight: 56

    // Delegates
    readonly property int walletDelegateHeight: 63
    readonly property int statusLabelHeight: 21

    // Radius
    readonly property int baseRadius: 7
    readonly property int rectangleRadius: 10
    readonly property int labelRadius: 4
    readonly property int checkBoxRadius: 3

    // Images
    readonly property int logoWidth: 120
    readonly property int logoHeight: 42
    readonly property int popupImgHeight: 72
    readonly property int projectImgHeight: 139
    readonly property int workImgHeight: 191

    readonly property int borderWidth: 1
    readonly property int separatorHeight: 2

    // Header
    readonly property int headerHeight: 60
    readonly property color headerBackgroundColor: bgColor
    readonly property font headerTitleFont: Qt.font({
        family: appFontFamily,
        styleName: "SemiBold",
        pixelSize: 20
    })
    readonly property color headerTitleFontColor: "#414D55"
    readonly property int backButtonClickAreaWidth: 40
    readonly property size backButtonIconSize: Qt.size(10, 18)
    readonly property int menuButtonClickAreaWidth: 60
    readonly property size menuButtonIconSize: Qt.size(27, 15)

    // Internet connection issue banner
    readonly property int internetConnectionIssueBannerHeight: 40
    readonly property color internetConnectionIssueBannerColor: headerBackgroundColor
    readonly property font internetConnectionIssueBannerFont: Qt.font({
        family: appFontFamily,
        styleName: "Bold",
        pixelSize: 14
    })
    readonly property color internetConnectionIssueLabelColor: errorColor
    readonly property size internetConnectionIssueIconSize: Qt.size(14, 14)



    // Dashboard
    readonly property int dashboardListTopMargin: 30
    readonly property int dashboardListSideMargin: 16
    readonly property int dashboardListDelegateSpacing: 20
    readonly property int dashboardDelegateWidth: 328
    readonly property int dashboardDelegateHeight: 170
    readonly property int dashboardDelegateLeftMargin: 30
    readonly property int dashboardDelegateRightMargin: 40
    readonly property color dashboardDelegateBackgroundColor: "#FFFFFF"
    readonly property color dashboardDelegateBackgroundGradientStartColor: dashboardDelegateBackgroundColor
    readonly property color dashboardDelegateBackgroundGradientEndColor: "#EDF0F6"
    readonly property int dashboardDelegateBackgroundRadius: 10
    readonly property int dashboardDelegateBackgroundBorderWidth: 2
    readonly property color dashboardDelegateBackgroundBorderColor: dashboardDelegateBackgroundColor
    readonly property font dashboardDelegatePrimaryLabelFont: Qt.font({
        family: appFontFamily,
        styleName: "SemiBold",
        pixelSize: 20
    })
    readonly property color dashboardDelegatePrimaryLabelFontColor: "#414D55"
    readonly property font dashboardDelegateSecondaryLabelFont: Qt.font({
        family: appFontFamily,
        styleName: "Regular",
        pixelSize: 14
    })
    readonly property color dashboardDelegateSecondaryLabelFontColor: "#778699"
    readonly property size dashboardDelegateIconSize: Qt.size(96, 96)
    readonly property int dashboardDelegateShadowHorizontalOffset: 5
    readonly property int dashboardDelegateShadowVerticalOffset: 15
    readonly property int dashboardDelegateShadowRadius: 30
    readonly property color dashboardDelegateShadowColor: "#29000000"
}
