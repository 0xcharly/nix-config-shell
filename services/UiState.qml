pragma Singleton

import Quickshell

Singleton {
  property bool showOsd: false

  property var screens: new Map()

  function load(screen: ShellScreen, state: var): void {
    screens.set(Hypr.monitorFor(screen), state);
  }

  function getForActive(): PersistentProperties {
    return screens.get(Hypr.focusedMonitor)
  }
}
