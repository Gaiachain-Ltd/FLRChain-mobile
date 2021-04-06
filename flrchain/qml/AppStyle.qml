pragma Singleton

import QtQuick 2.15

QtObject {

//colors
property color accentColor: "#23BC3D"
property color bgColor: "#FFFFFF"
property color shadowedBgColor: "#FAFAFD"
property color baseLabelColor: "#778699"
property color grayBgColor: "#E2E9F0"
property color colorTransparent: "#00ffffff"
property color darkLabelColor: "#253F50"
property color inputBgColor: "#F7F9FB"
property color placeholderColor: "#C0C7D4"
property color mediumLabelColor: "#72809D"
property color buttonSecColor: "#06BCC1"
property color yellowDelegateColor: "#FFFCE2"
property color yellowLabelColor: "#FFC423"
property color errorColor: "#FE2121"
property color sectionColor: "#EDEEF2"
property color grayLabelColor: "#606060"

//font
property int fontMicro: 10
property int fontTiny: 12
property int fontSmall: 14
property int fontMedium: 15
property int fontBig: 17
property int fontLarge: 20
property int fontUltra: 22
property int fontMax: 29

//margins
property int microMargin: 5
property int tinyMargin: 10
property int smallMargin: 16
property int baseMargin: 20
property int bigMargin: 30
property int ultraMargin: 40

//icons
property int iconSize: 18
property int iconMedium: 21
property int iconBig: 26
property int iconUltra: 32

//buttons
property int buttonHeight: 42
property int iconButtonHeight: 40
property int menuButtonHeight: 58
property int checkboxHeight: 16

//inputs
property int textInputHeight: 36
property int bigInputHeight: 56

//delegates
property int dashboardDelegateHeight: 223
property int walletDelegateHeight: 63
property int headerHeight: 60
property int statusLabelHeight: 21

//radius
property int baseRadius: 7
property int rectangleRadius: 10
property int labelRadius: 4
property int checkBoxRadius: 3

//images
property int logoWidth: 120
property int logoHeight: 42
property int popupImgHeight: 72
property int projectImgHeight: 139
property int workImgHeight: 191

property int borderWidth: 1
property int separatorHeight: 2
}
