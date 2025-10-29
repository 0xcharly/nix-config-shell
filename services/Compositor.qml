pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.I3
import QtQuick

// https://wiki.hypr.land/Configuring/Dispatchers/
Singleton {
    id: root

    readonly property string name: Quickshell.env("XDG_CURRENT_DESKTOP")
    readonly property int activeWorkspaceId: {
        switch (name) {
        case "Hyprland":
            return Hyprland.focusedWorkspace?.id ?? 1;
        case "none+i3":
        case "sway":
            return I3.focusedWorkspace?.id ?? 1;
        }
        return 0;
    }
    readonly property var workspaces: {
        switch (name) {
        case "Hyprland":
            return Hyprland.workspaces
        case "none+i3":
        case "sway":
            return I3.workspaces
        }
        return undefined;
    }

    function getWorkspaceName(workspace: var): string {
        return workspace?.name || workspace?.id.toString() || "";
    }

    function isWorkspaceActive(workspace: var): bool {
        return workspace?.active ?? false;
    }

    function goToWorkspace(workspace: var): void {
        goToWorkspaceId(workspace?.id ?? 1);
    }

    function goToWorkspaceId(workspaceId: int): void {
        if (root.activeWorkspaceId === workspaceId) {
            return;
        }

        switch (root.name) {
        case "Hyprland":
            Hyprland.dispatch(`workspace ${workspaceId}`);
            break;
        case "none+i3":
        case "sway":
            I3.dispatch(`workspace number ${workspaceId}`);
            break;
        }
    }

    function goToNextOccupiedWorkspace(): void {
        switch (root.name) {
        case "Hyprland":
            Hyprland.dispatch("workspace m+1");
            break;
        case "none+i3":
        case "sway":
            I3.dispatch("workspace next");
            break;
        }
    }

    function goToPreviousOccupiedWorkspace(): void {
        switch (root.name) {
        case "Hyprland":
            Hyprland.dispatch("workspace m-1");
            break;
        case "none+i3":
        case "sway":
            I3.dispatch("workspace prev");
            break;
        }
    }
}
