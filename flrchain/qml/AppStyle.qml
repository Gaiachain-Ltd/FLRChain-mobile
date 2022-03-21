pragma Singleton

import QtQuick 2.15

QtObject {

    readonly property string appFontFamily: "Open Sans"
    readonly property font defaultFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: 14})

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

    // Button
    readonly property font buttonFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 16})
    readonly property size defaultButtonSize: Qt.size(288, 42)
    readonly property int defaultButtonRadius: 7
    readonly property int defaultButtonBorderWidth: 1
    readonly property color primaryButtonBackgroundColor: "#06BCC1"
    readonly property color primaryButtonBorderColor: primaryButtonBackgroundColor
    readonly property color primaryButtonFontColor: "#FFFFFF"
    readonly property color secondaryButtonBackgroundColor: "#FFFFFF"
    readonly property color secondaryButtonBorderColor: "#06BCC1"
    readonly property color secondaryButtonFontColor: secondaryButtonBorderColor

    // CheckBox
    readonly property size checkboxSize: Qt.size(20, 20)
    readonly property size checkboxTickSize: Qt.size(11, 9)
    readonly property int checkboxSpacing: 7
    readonly property int checkboxBorderWidth: 1
    readonly property int checkboxBorderRadius: 3
    readonly property color checkboxBorderColor: "#DCE0E7"
    readonly property font checkboxLabelFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 10})
    readonly property color checkBoxLabelFontColor: "#253F50"

    // TextInput
    readonly property size defaultTextInputSize: Qt.size(288, 36)
    readonly property int textInputRadius: 7
    readonly property color textInputValidBackgroundColor: "#F7F9FB"
    readonly property color textInputInvalidBackgroundColor: "#FBF7F7"
    readonly property int textInputPadding: 16
    readonly property font textInputFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 12})
    readonly property color textInputValidFontColor: "#253F50"
    readonly property color textInputInvalidFontColor: errorColor
    readonly property color textInputPlaceholderFontColor: "#C0C7D4"

    // Pane
    readonly property int panePadding: 20
    readonly property color paneBackgroundColor: "#FFFFFF"
    readonly property int paneBackgroundRadius: 7
    readonly property int paneShadowHorizontalOffset: 5
    readonly property int paneShadowVerticalOffset: 15
    readonly property int paneShadowRadius: 30
    readonly property color paneShadowColor: "#29000000"

    // FormPane (used on login and register pages)
    readonly property int formPaneVerticalSpacing: 20
    readonly property font formPaneTitleFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 20})
    readonly property color formPaneTitleFontColor: "#414D55"
    readonly property font formPaneSubtitleFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 12})
    readonly property color formPaneSubtitleFontColor: "#778699"
    readonly property color formPaneSeparatorColor: "#FAFAFD"

    // Login and Register pages
    readonly property color loginPageBackgroundColor: "#FAFAFD"
    readonly property int loginPageSideMargin: 16
    readonly property int loginPageTopMargin: 50
    readonly property int loginPageSpacing: 32
    readonly property size loginPageLogoSize: Qt.size(160, 60)
    readonly property size loginPageIconSize: Qt.size(96, 96)
    readonly property int loginPanelPadding: 20
    readonly property font loginPanelInputTitleFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 10})
    readonly property color loginPanelInputTitleFontColor: "#72809D"
    readonly property font loginPanelErrorMessageFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 12})
    readonly property color loginPanelErrorMessageFontColor: errorColor
    readonly property font loginPanelForgotPasswordFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 12})
    readonly property color loginPanelForgotPasswordColor: "#06BCC1"
    readonly property int registrationPageTopBottomMargin: 20
    readonly property font registrationTermsFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 12})
    readonly property color registrationTermsFontInfoColor: "#606060"
    readonly property color registrationTermsFontLinkColor: "#06BCC1"

    // Header
    readonly property int headerHeight: 60
    readonly property color headerBackgroundColor: bgColor
    readonly property font headerTitleFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 20})
    readonly property color headerTitleFontColor: "#414D55"
    readonly property int backButtonClickAreaWidth: 40
    readonly property size backButtonIconSize: Qt.size(10, 18)
    readonly property int menuButtonClickAreaWidth: 60
    readonly property size menuButtonIconSize: Qt.size(27, 15)

    // Internet connection issue banner
    readonly property int internetConnectionIssueBannerHeight: 40
    readonly property color internetConnectionIssueBannerColor: headerBackgroundColor
    readonly property font internetConnectionIssueBannerFont: Qt.font({family: appFontFamily, styleName: "Bold", pixelSize: 14})
    readonly property color internetConnectionIssueLabelColor: errorColor
    readonly property size internetConnectionIssueIconSize: Qt.size(14, 14)

    // Menu
    readonly property int menuPadding: 20
    readonly property int menuItemHeight: 58
    readonly property size menuItemIconSize: Qt.size(18, 18)
    readonly property size menuCloseIconSize: Qt.size(20, 20)
    readonly property int menuSeparatorHeight: 1
    readonly property color menuSeparatorColor: "#EDEEF2"
    readonly property font menuUserNameFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: 20})
    readonly property color menuUserNameFontColor: "#06BCC1"
    readonly property font menuUserEmailFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 14})
    readonly property color menuUserEmailFontColor: "#606C83"
    readonly property font menuItemLabelFont: Qt.font({family: appFontFamily, styleName: "#72809D", pixelSize: 14})
    readonly property color menuItemLabelFontColor: "#72809D"
    readonly property color menuItemLogoutLabelFontColor: "#FE2121"

    // Dashboard page
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
    readonly property font dashboardDelegatePrimaryLabelFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: 20})
    readonly property color dashboardDelegatePrimaryLabelFontColor: "#414D55"
    readonly property font dashboardDelegateSecondaryLabelFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: 14})
    readonly property color dashboardDelegateSecondaryLabelFontColor: "#778699"
    readonly property size dashboardDelegateIconSize: Qt.size(96, 96)
    readonly property int dashboardDelegateShadowHorizontalOffset: 5
    readonly property int dashboardDelegateShadowVerticalOffset: 15
    readonly property int dashboardDelegateShadowRadius: 30
    readonly property color dashboardDelegateShadowColor: "#29000000"
}
