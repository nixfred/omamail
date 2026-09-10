pragma Singleton
import QtQuick

QtObject {
  readonly property color foreground: Qt.rgba(1, 1, 1, 1)
  readonly property color accent: Qt.rgba(1, 0.5, 0, 1)
  readonly property color urgent: Qt.rgba(1, 0.35, 0.35, 1)
  readonly property var popups: ({ background: Qt.rgba(0.08, 0.09, 0.12, 1), text: Qt.rgba(1, 1, 1, 1) })
}
