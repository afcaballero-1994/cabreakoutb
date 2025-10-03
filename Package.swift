// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cabreakoutb",
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
          name: "cabreakoutb",
          dependencies: ["Raylib"],
          path: "Sources",
          exclude: ["Raylib/lib/libraylib.a"],
          //swiftSettings: [.enableExperimentalFeature("Embedded")],
        ),

        .target(
          name: "Raylib",
          path: "Sources/Raylib",
          linkerSettings: [
            .unsafeFlags(["-LSources/Raylib/lib", "-lraylib", "-lm"]),
          ]
        )
    ]
)
