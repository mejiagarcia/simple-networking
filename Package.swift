// swift-tools-version:5.4
import PackageDescription

let package = Package(
  name: "Simple-Networking",
  platforms: [
    .iOS(.v10)
  ],
  products: [
    .library(
      name: "Simple-Networking",
      targets: ["Simple-Networking"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Simple-Networking",
      dependencies: [],
      path: "SimpleNetworking/SimpleNetworking/Source"
    )
  ]
)
