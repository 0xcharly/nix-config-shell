pragma ComponentBehavior: Bound

import qs.config.tokens.feature as FeatureTokens
import qs.components
import qs.services
import Quickshell
import QtQuick
import QtQuick.Layouts

ArcRectangle {
    id: root

    required property ShellScreen screen
    required property FeatureTokens.Workspaces theme

    readonly property int activeWsId: Hypr.monitorFor(screen)?.activeWorkspace?.id ?? 1

    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth

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

            Workspace {
                parentTheme: root.theme
            }
        }
    }
}
