import QtQuick 2.15
import QtQuick.Controls 2.15

StackView {
    id: stack
    initialItem: {}

    pushEnter: Transition {
    }

    pushExit: Transition {

    }

    popEnter: Transition {
    }

    popExit: Transition {
    }

    function pushPageItem(item) {
        stack.push(item)
    }

    function pushPage(address, page) {
        var component = Qt.createComponent(address);
        if (component.status === Component.Error) {
            console.log(component.errorString())
        } else if (component.status === Component.Ready) {
            var obj = component.createObject(stack, {"page": page})
            pushPageItem(obj)
            return obj
        } else {
            console.warn("PAGE not loaded", address)
        }
        return undefined
    }
}
