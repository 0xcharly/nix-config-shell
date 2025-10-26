pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string date: Qt.locale("ja_JP").toString(clock.date, "d日 (ddd)")
  readonly property string time: Qt.formatTime(clock.date, "hh:mm")
  readonly property string datetime: Qt.locale("ja_JP").toString(clock.date, "d日 (ddd) hh:mm")

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
