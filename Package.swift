// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDependencyInjection",
    products: [
        .library(
            name: "SwiftDependencyInjection",
            targets: ["SwiftDependencyInjection"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftDependencyInjection",
            dependencies: []),
        .testTarget(
            name: "SwiftDependencyInjectionTests",
            dependencies: ["SwiftDependencyInjection"]),
    ]
)
