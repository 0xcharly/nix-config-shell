pragma Singleton

import Quickshell

Singleton {
  property bool showOsd: false

  property var screens: new Map()

  function load(screen: ShellScreen, state: var): void {
    screens.set(Compositor.monitorFor(screen), state);
  }

  function getForActive(): PersistentProperties {
    return screens.get(Compositor.focusedMonitor)
  }
}
