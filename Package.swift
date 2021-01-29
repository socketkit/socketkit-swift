// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Socketkit",
  platforms: [
    .iOS(.v12_1),
    .tvOS(.v12),
    .watchOS(.v6),
    .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "Socketkit",
      targets: ["Socketkit"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Socketkit",
      dependencies: [],
      path: "Sources"
    ),
    .testTarget(
      name: "SocketkitTests",
      dependencies: ["Socketkit"],
      path: "Tests"
    ),
  ]
)
