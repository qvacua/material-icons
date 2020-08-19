/**
 * Tae Won Ha - http://taewon.de - @hataewon
 * See LICENSE
 */

import Cocoa
import os

class FontLoader {

  static let shared = FontLoader()

  func font(ofStyle style: Style, size: CGFloat) -> NSFont {
    guard let fontName = fontNames[style],
          let font = NSFont(name: fontName, size: size) else {

      return NSFont.systemFont(ofSize: size)
    }

    return font
  }

  private init() {
    self.loadAllFonts()
  }

  private func loadAllFonts() {
    Style.allCases.forEach { style in
      do {
        try self.loadFont(style)
      } catch {
        os_log(
          "Font could not be loaded. It could be that the font is already loaded by the OS.",
          log: self.log,
          type: .error
        )
      }
    }
  }

  // From https://github.com/thii/FontAwesome.swift
  private func loadFont(_ style: Style) throws {
    guard let url = Bundle.module.url(forResource: fontFileNames[style], withExtension: "woff2") else {
      throw Error.fontNotLoaded(style: style)
    }

    try self.loadFont(url)
  }

  private func loadFont(_ url: URL) throws {
    guard let data = try? Data(contentsOf: url),
          let provider = CGDataProvider(data: data as CFData),
          let font = CGFont(provider) else {

      throw Error.fontNotLoaded(url: url)
    }

    var cferr: Unmanaged<CFError>?
    if CTFontManagerRegisterGraphicsFont(font, &cferr) { return }

    throw Error.fontNotLoaded(url: url, msg: cferr?.takeUnretainedValue().localizedDescription)
  }

  private let log = OSLog(subsystem: Defs.bundleIdentifier, category: "general")
}

private let fontFileNames: [Style: String] = [
  .outlined: "mi-outlined-v23",
  .filled: "mi-filled-v54",
  .round: "mi-round-v23",
  .sharp: "mi-sharp-v24",
  .twoTone: "mi-twotone-v22",
]

private let fontNames: [Style: String] = [
  .outlined: "MaterialIconsOutlined-Regular",
  .filled: "MaterialIcons-Regular",
  .round: "MaterialIconsRound-Regular",
  .sharp: "MaterialIconsSharp-Regular",
  .twoTone: "MaterialIconsTwoTone-Regular",
]
