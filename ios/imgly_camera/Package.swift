// swift-tools-version: 6.1
// 6.1 is the parse floor for the trailing-comma syntax SwiftFormat enforces (SE-0439). The
// toolchain floor comes from the IMGLYUI-swift dependency (tools 6.3.1) — do not lower this.
import PackageDescription

let package = Package(
  name: "imgly_camera",
  platforms: [
    .iOS("16.0"),
  ],
  products: [
    .library(name: "imgly-camera", targets: ["imgly_camera"]),
  ],
  dependencies: [
    // Pinned exactly: the plugin and IMGLYUI are versioned in lockstep, matching the podspec.
    .package(url: "https://github.com/imgly/IMGLYUI-swift.git", exact: "1.82.1-rc.1"),
  ],
  targets: [
    .target(
      name: "imgly_camera",
      dependencies: [
        .product(name: "IMGLYCamera", package: "IMGLYUI-swift"),
      ],
    ),
  ],
  // The plugin sources are written for the Swift 5 language mode (see swift_version in the podspec).
  swiftLanguageModes: [.v5],
)
