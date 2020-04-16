// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Poppo",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Poppo", targets: ["Poppo"]),
    ],
    dependencies: [
        .package(name: "Cryptor", url: "https://github.com/IBM-Swift/BlueCryptor.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "Poppo", dependencies: [
            .product(name: "Cryptor", package: "Cryptor"),
        ], path: "./Sources"),
        .testTarget(name: "PoppoTests", dependencies: [
            .target(name: "Poppo"),
        ])
    ]
)
