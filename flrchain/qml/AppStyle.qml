/*
 * Copyright (C) 2022  Milo Solutions
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 */

pragma Singleton

import QtQuick 2.15

QtObject {

    // Colors
    readonly property color accentColor: "#06BCC1"
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
    readonly property color successColor: "#23BC3D"
    readonly property color errorColor: "#FE2121"
    readonly property color sectionColor: "#EDEEF2"
    readonly property color grayLabelColor: "#606060"

    // Typography
    readonly property string appFontFamily: "Open Sans"

    readonly property int microFontPixelSize: 10
    readonly property int tinyFontPixelSize: 12
    readonly property int smallFontPixelSize: 14
    readonly property int mediumFontPixelSize: 16
    readonly property int largeFontPixelSize: 18
    readonly property int extraLargeFontPixelSize: 20
    readonly property int hugeFontPixelSize: 22

    readonly property font regularMicroFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: microFontPixelSize})
    readonly property font regularTinyFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: tinyFontPixelSize})
    readonly property font regularSmallFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: smallFontPixelSize})
    readonly property font regularMediumFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: mediumFontPixelSize})
    readonly property font regularLargeFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: largeFontPixelSize})
    readonly property font regularExtraLargeFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: extraLargeFontPixelSize})
    readonly property font regularHugeFont: Qt.font({family: appFontFamily, styleName: "Regular", pixelSize: hugeFontPixelSize})

    readonly property font semiBoldMicroFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: microFontPixelSize})
    readonly property font semiBoldTinyFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: tinyFontPixelSize})
    readonly property font semiBoldSmallFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: smallFontPixelSize})
    readonly property font semiBoldMediumFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: mediumFontPixelSize})
    readonly property font semiBoldLargeFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: largeFontPixelSize})
    readonly property font semiBoldExtraLargeFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: extraLargeFontPixelSize})
    readonly property font semiBoldHugeFont: Qt.font({family: appFontFamily, styleName: "SemiBold", pixelSize: hugeFontPixelSize})

    readonly property font boldMicroFont: Qt.font({family: appFontFamily, styleName: "Bold", pixelSize: microFontPixelSize})
    readonly property font boldTinyFont: Qt.font({family: appFontFamily, styleName: "Bold", pixelSize: tinyFontPixelSize})
    readonly property font boldSmallFont: Qt.font({family: appFontFamily, styleName: "Bold", pixelSize: smallFontPixelSize})
    readonly property font boldMediumFont: Qt.font({family: appFontFamily, styleName: "Bold", pixelSize: mediumFontPixelSize})
    readonly property font boldLargeFont: Qt.font({family: appFontFamily, styleName: "Bold", pixelSize: largeFontPixelSize})
    readonly property font boldExtraLargeFont: Qt.font({family: appFontFamily, styleName: "Bold", pixelSize: extraLargeFontPixelSize})
    readonly property font boldHugeFont: Qt.font({family: appFontFamily, styleName: "Bold", pixelSize: hugeFontPixelSize})

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
    readonly property int separatorHeight: 1

    // Button
    readonly property font buttonFont: semiBoldMediumFont
    readonly property size defaultButtonSize: Qt.size(288, 42)
    readonly property int defaultButtonRadius: 7
    readonly property int defaultButtonBorderWidth: 1
    readonly property color primaryButtonBackgroundColor: "#06BCC1"
    readonly property color primaryButtonBorderColor: primaryButtonBackgroundColor
    readonly property color primaryButtonFontColor: "#FFFFFF"
    readonly property color secondaryButtonBackgroundColor: "#FFFFFF"
    readonly property color secondaryButtonBorderColor: "#06BCC1"
    readonly property color secondaryButtonFontColor: secondaryButtonBorderColor

    // TabButton
    readonly property int defaultTabButtonHeight: 42
    readonly property color tabButtonBackgroundInactiveColor: "#EDEEF2"
    readonly property color tabButtonBackgroundActiveColor: "#06BCC1"
    readonly property font tabButtonFont: semiBoldMediumFont
    readonly property color tabButtonLabelInactiveColor: "#414D55"
    readonly property color tabButtonLabelActiveColor: "#FFFFFF"

    // CheckBox
    readonly property size checkboxSize: Qt.size(20, 20)
    readonly property size checkboxTickSize: Qt.size(11, 9)
    readonly property int checkboxSpacing: 7
    readonly property int checkboxBorderWidth: 1
    readonly property int checkboxBorderRadius: 3
    readonly property color checkboxBorderColor: "#DCE0E7"
    readonly property font checkboxLabelFont: semiBoldMicroFont
    readonly property color checkBoxLabelFontColor: "#253F50"

    // ComboBox
    readonly property color comboBoxBackgroundColor: "#F7F9FB"
    readonly property int comboBoxBackgroundRadius: 7
    readonly property int comboBoxPadding: 10
    readonly property int comboBoxItemHeight: 60
    readonly property int comboBoxItemSpacing: 2
    readonly property font comboBoxFont: semiBoldSmallFont
    readonly property color comboBoxCurrentTextFontColor: "#253F50"
    readonly property color comboBoxDelegateTextFontColor: "#72809D"

    // TextInput
    readonly property size defaultTextInputSize: Qt.size(288, 36)
    readonly property int textInputRadius: 7
    readonly property color textInputValidBackgroundColor: "#F7F9FB"
    readonly property color textInputInvalidBackgroundColor: "#FBF7F7"
    readonly property int textInputPadding: 16
    readonly property font textInputFont: semiBoldSmallFont
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
    readonly property font formPaneTitleFont: semiBoldExtraLargeFont
    readonly property color formPaneTitleFontColor: "#414D55"
    readonly property font formPaneSubtitleFont: semiBoldTinyFont
    readonly property color formPaneSubtitleFontColor: "#778699"
    readonly property color formPaneSeparatorColor: "#FAFAFD"

    // Popup
    readonly property int popupSideMargins: 16
    readonly property int popupLeftRightPadding: 20
    readonly property int popupTopBottomPadding: 30
    readonly property int popupSpacing: 20
    readonly property color popupBackgroundColor: "#FFFFFF"
    readonly property size popupIconSize: Qt.size(72, 72)
    readonly property font popupTitleFont: semiBoldHugeFont
    readonly property color popupTitleFontColor: "#253F50"
    readonly property font popupTextFont: regularSmallFont
    readonly property color popupTextFontColor: popupTitleFontColor
    readonly property color popupSuccessColor: "#23BC3D"
    readonly property color popupErrorColor: "#FE2121"
    readonly property font popupHighlightedTextFont: boldSmallFont

    // Login and Register pages
    readonly property color loginPageBackgroundColor: "#FAFAFD"
    readonly property int loginPageSideMargin: 16
    readonly property int loginPageTopMargin: 50
    readonly property int loginPageSpacing: 32
    readonly property size loginPageLogoSize: Qt.size(160, 60)
    readonly property size loginPageIconSize: Qt.size(96, 96)
    readonly property int loginPanelPadding: 20
    readonly property font loginPanelInputTitleFont: semiBoldMicroFont
    readonly property color loginPanelInputTitleFontColor: "#72809D"
    readonly property font loginPanelErrorMessageFont: semiBoldTinyFont
    readonly property color loginPanelErrorMessageFontColor: errorColor
    readonly property font loginPanelForgotPasswordFont: semiBoldTinyFont
    readonly property color loginPanelForgotPasswordColor: "#06BCC1"
    readonly property int registrationPageTopBottomMargin: 20
    readonly property font registrationTermsFont: semiBoldTinyFont
    readonly property color registrationTermsFontInfoColor: "#606060"
    readonly property color registrationTermsFontLinkColor: "#06BCC1"

    // Header
    readonly property int headerHeight: 60
    readonly property color headerBackgroundColor: bgColor
    readonly property color headerSeparatorColor: "#EDEEF2"
    readonly property font headerTitleFont: semiBoldExtraLargeFont
    readonly property color headerTitleFontColor: "#414D55"
    readonly property int backButtonClickAreaWidth: 40
    readonly property size backButtonIconSize: Qt.size(10, 18)
    readonly property int menuButtonClickAreaWidth: 60
    readonly property size menuButtonIconSize: Qt.size(27, 15)

    // Internet connection issue banner
    readonly property int internetConnectionIssueBannerHeight: 40
    readonly property color internetConnectionIssueBannerColor: headerBackgroundColor
    readonly property font internetConnectionIssueBannerFont: boldSmallFont
    readonly property color internetConnectionIssueLabelColor: errorColor
    readonly property size internetConnectionIssueIconSize: Qt.size(14, 14)

    // Menu
    readonly property int menuPadding: 20
    readonly property int menuItemHeight: 58
    readonly property size menuItemIconSize: Qt.size(18, 18)
    readonly property size menuCloseIconSize: Qt.size(20, 20)
    readonly property int menuSeparatorHeight: 1
    readonly property color menuSeparatorColor: "#EDEEF2"
    readonly property font menuUserNameFont: regularExtraLargeFont
    readonly property color menuUserNameFontColor: "#06BCC1"
    readonly property font menuUserEmailFont: semiBoldSmallFont
    readonly property color menuUserEmailFontColor: "#606C83"
    readonly property font menuItemLabelFont: semiBoldSmallFont
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
    readonly property font dashboardDelegatePrimaryLabelFont: semiBoldExtraLargeFont
    readonly property color dashboardDelegatePrimaryLabelFontColor: "#414D55"
    readonly property font dashboardDelegateSecondaryLabelFont: regularSmallFont
    readonly property color dashboardDelegateSecondaryLabelFontColor: "#778699"
    readonly property size dashboardDelegateIconSize: Qt.size(96, 96)
    readonly property int dashboardDelegateShadowHorizontalOffset: 5
    readonly property int dashboardDelegateShadowVerticalOffset: 15
    readonly property int dashboardDelegateShadowRadius: 30
    readonly property color dashboardDelegateShadowColor: "#29000000"

    // Project list (aka earn rewards) page
    readonly property int projectListSideMargins: 16
    readonly property font projectListTitleFont: semiBoldExtraLargeFont
    readonly property color projectListTitleFontColor: "#414D55"
    readonly property int projectListDelegatePadding: 20
    readonly property int projectListDelegateSpacing: 20
    readonly property font projectListDelegateNameFont: semiBoldExtraLargeFont
    readonly property color projectListDelegateNameFontColor: "#414D55"
    readonly property size projectListDelegateIconSize: Qt.size(18, 18)
    readonly property font projectListDelegateDateFont: semiBoldTinyFont
    readonly property font projectListDelegateDescriptionTitleFont: boldSmallFont
    readonly property font projectListDelegateDescriptionFont: semiBoldSmallFont
    readonly property color projectListDelegateFontColor: "#72809D"
    readonly property int projectListDelegateDescriptionSpacing: 10
    readonly property font assignmentStatusLabelFont: semiBoldMicroFont
    readonly property color assignmentStatusLabelFontColor: "#FFFFFF"
    readonly property int assignmentStatusLabelRadius: 2
    readonly property int assignmentStatusLabelTopBottomPadding: 2
    readonly property int assignmentStatusLabelLeftRightPadding: 4
    readonly property size investmentStatusIndicatorSize: Qt.size(10, 10)
    readonly property int investmentStatusIndicatorRadius: 2
    readonly property font myTaskDelegateInfoTypeFont: semiBoldSmallFont
    readonly property font myTaskDelegateProjectNameFont: regularSmallFont
    readonly property font myTaskDelegateTaskDataFont: boldSmallFont
    readonly property color myTaskDelegateInfoTypeFontColor: "#414D55"
    readonly property color myTaskDelegateDataFontColor: "#72809D"

    // Project details page
    readonly property int projectDetailsSideMargins: 16
    readonly property int projectDetailsTopBottomMargin: 20
    readonly property int projectDetailsContentSpacing: 20
    readonly property font projectDetailsTitleFont: semiBoldExtraLargeFont
    readonly property color projectDetailsTitleFontColor: "#414D55"
    readonly property int projectDetailsPanePadding: 20
    readonly property int projectDetailsSectionSpacing: 10
    readonly property font projectDetailsPaneSectionTitleFont: semiBoldSmallFont
    readonly property color projectDetailsPaneSectionTitleFontColor: "#06BCC1"
    readonly property font projectDetailsPaneContentFont: semiBoldTinyFont
    readonly property color projectDetailsPaneContentFontColor: "#606C83"

    // Project status label
    readonly property color projectFundraisingColor: "#FFB623"
    readonly property color projectActiveColor: "#00B854"
    readonly property color projectClosedColor: "#06BCC1"

    // Project assignment status label
    readonly property color assignmentNewColor: "#71809C"
    readonly property color assignmentWaitingColor: "#FF9123"
    readonly property color assignmentAcceptedColor: "#00B854"
    readonly property color assignmentRejectedColor: "#FE2121"

    // Project task delegate
    readonly property size projectTaskFavouriteButtonSize: Qt.size(24, 22)

    // Wallet page
    readonly property int walletPagePadding: 16
    readonly property int walletPageSectionSpacing: 24
    readonly property int walletPageTitleSpacing: 12
    readonly property int walletPagePanePadding: 20
    readonly property font walletPageSectionTitleFont: semiBoldExtraLargeFont
    readonly property color walletPageSectionTitleFontColor: "#414D55"
    readonly property font balanceDelegateTitleFont: semiBoldMediumFont
    readonly property color balanceDelegateTitleFontColor: "#72809D"
    readonly property font balanceDelegateAmountFont: semiBoldHugeFont
    readonly property color balanceDelegateAmountFontColor: "#253F50"
    readonly property font balanceDelegateCurrencyFont: regularHugeFont
    readonly property color balanceDelegateCurrencyFontColor: "#253F50"
    readonly property font transactionSectionFont: semiBoldTinyFont
    readonly property color transactionSectionFontColor: "#72809D"
    readonly property int transactionSectionSeparatorHeight: 1
    readonly property color transactionSectionSeparatorColor: "#C0C7D4"
    readonly property color transactionIncomingColor: successColor
    readonly property color transactionOutgoingColor: errorColor
    readonly property font transactionProjectFont: regularTinyFont
    readonly property color transactionProjectFontColor: "#72809D"
    readonly property font transactionTypeFont: semiBoldTinyFont
    readonly property color transactionTypeFontColor: "#253F50"
    readonly property font transactionAmountFont: balanceDelegateAmountFont
    readonly property font transactionCurrencyFont: balanceDelegateCurrencyFont

    // Cash out page
    readonly property int cashOutPageMargins: 16
    readonly property int cashOutPageSpacing: 20
    readonly property int cashOutInputTitleSpacing: 5
    readonly property int cashOutInputHeight: 60
    readonly property font cashOutInfoFont: semiBoldSmallFont
    readonly property color cashOutInfoFontColor: "#72809D"
    readonly property font cashOutInputTitleFont: semiBoldTinyFont
    readonly property color cashOutInputTitleFontColor: "#72809D"
    readonly property font cashOutAmountInputFont: semiBoldHugeFont
    readonly property color cashOutAmountInputFontColor: "#253F50"

    // Receive money page
    readonly property int receiveMoneyPagePadding: 16
    readonly property font receiveMoneyInfoFont: semiBoldSmallFont
    readonly property color receiveMoneyInfoFontColor: "#72809D"
    readonly property size receiveMoneyQrCodeSize: Qt.size(200, 200)
}
