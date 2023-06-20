// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CheckBox",
    platforms: [
       .iOS(.v8)
    ],
    products: [
        .library(name: "CheckBox", targets: ["CheckBox"])
    ],
    targets: [
        .target(name: "CheckBox", dependencies: [], path: "Classes")
    ]
)
