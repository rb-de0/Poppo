// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Poppo",
    products: [
        .library(name: "Poppo", targets: ["Poppo"]),
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/BlueCryptor.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "Poppo", dependencies: ["Cryptor"], path: "./Sources"),
        .testTarget(name: "PoppoTests", dependencies: ["Poppo"])
    ]
)
