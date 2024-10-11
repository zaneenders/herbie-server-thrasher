// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "herbie-server-thrasher",
    platforms: [
        .macOS("15.0")
    ],
    dependencies: [
        .package(url: "https://github.com/zaneenders/swift-fpcore", branch: "main"),
        .package(url: "https://github.com/apple/swift-nio", from: "2.74.0"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.23.0"),
    ],
    targets: [
        .executableTarget(
            name: "herbie-server-thrasher",
            dependencies: [
                .product(name: "FPCore", package: "swift-fpcore"),
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "_NIOFileSystem", package: "swift-nio"),
            ])
    ]
)
