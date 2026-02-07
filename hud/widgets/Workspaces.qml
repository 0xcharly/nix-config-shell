pragma ComponentBehavior: Bound

import qs.config
import qs.services
import Quickshell
import QtQuick
import QtQuick.Layouts

Widget {
    id: root

    required property ShellScreen screen
    readonly property int activeWsId: Hypr.monitorFor(screen)?.activeWorkspace?.id ?? 1

    theme: Config.theme.hud.widgets.workspaces

    implicitHeight: layout.implicitHeight + 2 * border.width
    implicitWidth: layout.implicitWidth + 2 * border.width

    MouseArea {
        anchors.fill: layout

        onWheel: event => {
            if (event.angleDelta.y > 0) {
                Hypr.goToNextOccupiedWorkspace();
            } else if (event.angleDelta.y < 0) {
                Hypr.goToPreviousOccupiedWorkspace();
            }
            event.accepted = true;
        }
    }

    RowLayout {
        id: layout
        spacing: root.theme.spacedBy

        Repeater {
            id: workspaces
            model: Hypr.workspacesFor(root.screen)

            Workspace {}
        }
    }
}
