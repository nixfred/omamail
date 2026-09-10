import QtQuick
import qs.Commons
import qs.Ui

// Provider artwork keeps its brand colours; the unread overlay follows the
// theme. Its width grows for the actual count instead of clipping neighbours.
Item {
  id: root

  property real iconSize: Style.space(24)
  property color color: Color.foreground
  property color badgeColor: Color.urgent
  property string badge: ""
  property bool crossed: false

  // Reserve the badge's overhang inside our bounds, not in the next slot.
  readonly property real badgeOffset: badge !== "" ? Style.space(4) : 0
  width: Math.max(iconSize + badgeOffset, badge !== "" ? unreadOverlay.width : 0)
  height: iconSize + badgeOffset
  implicitWidth: width
  implicitHeight: height

  Image {
    objectName: "gmailMark"
    width: root.iconSize
    height: root.iconSize
    anchors.left: parent.left
    source: "../assets/gmail.png"
    sourceSize.width: Math.round(root.iconSize * 2)
    fillMode: Image.PreserveAspectFit
    smooth: true
  }

  Rectangle {
    objectName: "disconnectedSlash"
    visible: root.crossed
    x: 0
    y: root.iconSize / 2
    width: root.iconSize
    height: Math.max(2, root.iconSize * 0.10)
    radius: height / 2
    color: root.color
    rotation: -45
  }

  BorderSurface {
    id: unreadOverlay
    objectName: "unreadOverlay"
    visible: root.badge !== ""
    width: Math.max(height, badgeLabel.implicitWidth + Style.space(6))
    height: Style.space(14)
    radius: height / 2
    color: root.badgeColor
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    borderSpec: Border.flat(Color.popups.background, 1)

    Text {
      id: badgeLabel
      objectName: "unreadLabel"
      anchors.centerIn: parent
      text: root.badge
      textFormat: Text.PlainText
      color: Color.popups.background
      font.family: Style.font.family
      font.pixelSize: Style.space(10)
      font.bold: true
    }
  }
}
