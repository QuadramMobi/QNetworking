// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "QNetworking",
    products: [
        .library(name: "QNetworking",  targets: ["QNetworking"])
    ],
    dependencies: [
        .package(url: "https://github.com/mxcl/PromiseKit", from: "6.8.0")
    ],
    targets: [
        .target(name: "QNetworking", path: "Sources")
    ]
)
