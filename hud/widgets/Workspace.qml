pragma ComponentBehavior: Bound

import qs.config
import qs.components
import qs.services
import QtQuick

AnimatedRectangle {
    id: root

    required property int index
    required property var modelData

    property bool isHovered: false
    property bool needsAttention: false
    readonly property ThemeConfig.Workspace theme: {
        if (needsAttention) {
            Config.theme.hud.widgets.workspaces.needsAttention;
        } else if (isHovered) {
            Config.theme.hud.widgets.workspaces.hovered;
        } else if (Compositor.ipc.isWorkspaceActive(modelData)) {
            Config.theme.hud.widgets.workspaces.active;
        } else {
            Config.theme.hud.widgets.workspaces.inactive;
        }
    }

    color: theme.color
    border.color: theme.border.color
    border.width: theme.border.width
    radius: theme.border.shape

    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth

    MouseArea {
        anchors.fill: layout
        hoverEnabled: true

        onClicked: Compositor.ipc.goToWorkspace(root.modelData)
        onEntered: root.isHovered = true
        onExited: root.isHovered = false
    }

    AnimatedText {
        id: layout

        anchors.fill: parent
        bottomPadding: root.theme.padding.bottom
        leftPadding: root.theme.padding.left
        rightPadding: root.theme.padding.right
        topPadding: root.theme.padding.top

        color: root.theme.contentColor
        style: root.theme.typography
        text: Compositor.ipc.getWorkspaceName(root.modelData)
    }
}
