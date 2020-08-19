/**
 * Tae Won Ha - http://taewon.de - @hataewon
 * See LICENSE
 */

import Cocoa

public struct Icon: Hashable {

  public var name: String
  public var unicode: String

  /**
   If `dimension` is smaller than 1 or `padding` is bigger than `dimension`,
   we return an empty `NSImage`.
   
   - parameters:
     - dimension: The resulting `NSImage` will have the size of `dimension` x `dimension`.
     - padding: The resulting `NSImage` will have padding on each side; 0 by default.
     - style: One of the styles of Material Icons; filled by default.
     - color: The foreground color; black by default.
     - backgroundColor: The background color; clear by default
   */
  public func asImage(
    dimension: CGFloat,
    padding: CGFloat = 0,
    style: Style = .filled,
    color: NSColor = .black,
    backgroundColor: NSColor = .clear
  ) -> NSImage {

    if dimension < 1 || dimension - padding < 1 { return NSImage() }

    let innerDimension = dimension - 2 * padding
    let fontSize = innerDimension
    let font = FontLoader.shared.font(ofStyle: style, size: fontSize)

    let attributedString = NSAttributedString(string: self.unicode, attributes: [
      NSAttributedString.Key.font: font,
      NSAttributedString.Key.foregroundColor: color,
    ])

    let image = NSImage(size: CGSize(width: dimension, height: dimension))

    image.lockFocus()
    backgroundColor.set()
    CGRect(x: 0, y: 0, width: dimension, height: dimension).fill()
    attributedString.draw(at: CGPoint(x: padding, y: padding))
    image.unlockFocus()

    return image
  }
}
