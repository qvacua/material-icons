/**
 * Tae Won Ha - http://taewon.de - @hataewon
 * See LICENSE
 */

import Cocoa
import MaterialIcons

@main
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet var window: NSWindow!
  @IBOutlet var imageView: NSImageView!

  @IBAction func showRandomIcon(_: Any?) {
    self.imageView.image = Icon.allIcons.randomElement()?.asImage(
      dimension: 320,
      padding: 12,
      style: Style.allCases.randomElement()!,
      color: .black,
      backgroundColor: .white
    )
  }

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    self.imageView.layer?.backgroundColor = NSColor.darkGray.cgColor
    self.showRandomIcon(nil)
  }
}
