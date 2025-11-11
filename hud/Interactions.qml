import qs.config
import qs.services
import Quickshell
import QtQuick

MouseArea {
    id: root

    required property ShellScreen screen
    required property Panels panels
    required property Item bar

    function withinPanelHeight(panel: Item, x: real, y: real): bool {
        const panelY = Config.theme.hud.border.width + panel.y;
        return y >= panelY - Config.theme.hud.border.shape && y <= panelY + panel.height + Config.theme.hud.border.shape;
    }

    function inRightPanel(panel: Item, x: real, y: real): bool {
        return x >= panel.x && withinPanelHeight(panel, x, y);
    }

    anchors.fill: parent
    hoverEnabled: true

    onContainsMouseChanged: {
        if (!containsMouse) {
            UiState.showOsd = false;
            root.panels.osd.hovered = false;
        }
    }

    onPositionChanged: event => {
        const x = event.x;
        const y = event.y;

        UiState.showOsd = inRightPanel(panels.osd, x, y);
        root.panels.osd.hovered = inRightPanel(panels.osd, x, y);
    }
}
