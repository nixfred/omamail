import QtQuick
import QtTest
import "../../components" as Components

Item {
  width: 100
  height: 60
  Components.GmailIcon { id: icon; x: 30; y: 15; iconSize: 24; badge: "4" }
  TestCase {
    name: "GmailBrandOverlay"
    when: windowShown
    function test_brand_and_readable_overlay() {
      var mark = findChild(icon, "gmailMark")
      verify(mark !== null, "draw the shipped Gmail artwork, not a generic envelope")
      tryCompare(mark, "status", Image.Ready)
      verify(String(mark.source).endsWith("/assets/gmail.png"))
      var pill = findChild(icon, "unreadOverlay")
      var label = findChild(icon, "unreadLabel")
      verify(label.font.pixelSize >= 10)
      for (var count of ["4", "99", "201", "1500", "123456"]) {
        icon.badge = count
        compare(label.text, count)
        verify(pill.width >= label.implicitWidth + 4)
        verify(pill.x < icon.width && pill.x + pill.width > 0, "badge overlaps logo")
        verify(pill.y < icon.height && pill.y + pill.height > 0)
        verify(pill.x >= 0 && pill.x + pill.width <= icon.width, "no spill into neighbours")
      }
      icon.badge = ""
      compare(pill.visible, false)
      icon.crossed = true
      compare(findChild(icon, "disconnectedSlash").visible, true)
    }
  }
}
