pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

// https://wiki.hypr.land/Configuring/Dispatchers/
Singleton {
    id: root

    readonly property int activeWorkspaceId: Hyprland.focusedWorkspace?.id ?? 1

    function getWorkspaceName(workspace: HyprlandWorkspace): string {
      return workspace?.name || workspace?.id?.toString() || ""
    }

    function isWorkspaceActive(workspace: HyprlandWorkspace): bool {
      return workspace?.active ?? false
    }

    function goToWorkspace(workspace: HyprlandWorkspace): void {
      goToWorkspaceId(workspace?.id ?? 1)
    }

    function goToWorkspaceId(workspaceId: int): void {
        if (Hyprland.focusedWorkspace?.id !== workspaceId) {
            Hyprland.dispatch(`workspace ${workspaceId}`);
        }
    }

    function goToNextOccupiedWorkspace(): void {
      Hyprland.dispatch("workspace m+1")
    }

    function goToPreviousOccupiedWorkspace(): void {
      Hyprland.dispatch("workspace m-1")
    }
}
