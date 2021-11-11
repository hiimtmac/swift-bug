// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swift-bug",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [],
    targets: [
        .executableTarget(name: "Run", dependencies: []),
    ]
)
