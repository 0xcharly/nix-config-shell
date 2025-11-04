pragma Singleton

import Quickshell
import Quickshell.I3

Singleton {
  id: root

  property var workspaces: I3.workspaces

  function monitorFor(screen: ShellScreen): var {
    return I3.monitorFor(screen);
  }

  function workspacesFor(screen: ShellScreen): var {
    let monitorId = monitorFor(screen)?.id;
    return root.workspaces.values.filter(ws => {
      return ws.monitor?.id === monitorId;
    });
  }

  function getWorkspaceName(workspace: I3Workspace): string {
    return workspace?.name || workspace?.id || "";
  }

  function isWorkspaceActive(workspace: I3Workspace): bool {
    return workspace?.active || false;
  }

  function goToWorkspace(workspace: I3Workspace): void {
    goToWorkspaceId(workspace?.id || -1);
  }

  function goToWorkspaceId(workspaceId: int): void {
    if (workspaceId < 0) return;
    if (root.activeWorkspaceId === workspaceId) return;
    I3.dispatch(`workspace number ${workspaceId}`);
  }

  function goToNextOccupiedWorkspace(): void {
    I3.dispatch("workspace next");
  }

  function goToPreviousOccupiedWorkspace(): void {
    I3.dispatch("workspace prev");
  }
}
