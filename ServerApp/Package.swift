// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServerApp",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "ServerApp", targets: ["ServerApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/awslabs/aws-sdk-swift", from: "0.2.6"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "ServerApp",
            dependencies: [
                .product(name: "AWSIvschat", package: "aws-sdk-swift"),
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
            ]
        )
    ]
)
