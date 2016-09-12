import PackageDescription

let package = Package(
    name: "Poppo",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/BlueCryptor", majorVersion: 0, minor: 7)
    ]
)
