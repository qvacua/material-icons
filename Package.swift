// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "MaterialIcons",
  platforms: [.macOS(.v12)],
  products: [
    .library(name: "MaterialIcons", targets: ["MaterialIcons"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "MaterialIcons",
      dependencies: [],
      exclude: ["MaterialIcons-Regular.ijmap"],
      resources: [
        .copy("mi-outlined-v23.woff2"),
        .copy("mi-filled-v54.woff2"),
        .copy("mi-round-v23.woff2"),
        .copy("mi-sharp-v24.woff2"),
        .copy("mi-twotone-v22.woff2"),
      ]
    ),
  ]
)
