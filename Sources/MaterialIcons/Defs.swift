/**
 * Tae Won Ha - http://taewon.de - @hataewon
 * See LICENSE
 */

import Foundation

class Defs {

  static let bundleIdentifier = "com.qvacua.MaterialIcons"
}

public enum Style: CaseIterable, Sendable {

  case outlined
  case filled
  case round
  case sharp
  case twoTone
}

public enum Error: Swift.Error {

  case fontNotLoaded(style: Style? = nil, url: URL? = nil, msg: String? = nil)
}
