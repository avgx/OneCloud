// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "OneCloud",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .tvOS(.v17),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "OneCloud",
            targets: ["OneCloud"]
        ),
        .library(
            name: "OneCloudData",
            targets: ["OneCloudData"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/avgx/RequestResponse", from: "2.0.0"),
        .package(url: "https://github.com/avgx/SafeEnum", from: "1.0.0"),
        .package(url: "https://github.com/avgx/EncodeDecode", from: "1.0.2"),
        .package(url: "https://github.com/auth0/JWTDecode.swift", from: "4.0.0"),
        .package(url: "https://github.com/avgx/JSONValue", from: "1.0.1"),
    ],
    targets: [
        .target(
            name: "OneCloud",
            dependencies: [
                .product(name: "RequestResponse", package: "RequestResponse"),
                .product(name: "SafeEnum", package: "SafeEnum"),
                .product(name: "JWTDecode", package: "JWTDecode.swift"),
            ]
        ),
        .target(
            name: "OneCloudData",
            dependencies: [
                .product(name: "RequestResponse", package: "RequestResponse"),
                .product(name: "JSONValue", package: "JSONValue"),
            ]
        ),
        .testTarget(
            name: "OneCloudTests",
            dependencies: [
                "OneCloud",
                .product(name: "EncodeDecode", package: "EncodeDecode"),
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "OneCloudDataTests",
            dependencies: ["OneCloudData"],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
