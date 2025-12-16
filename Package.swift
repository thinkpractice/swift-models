// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-models",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .executable(name: "Benchmarks", targets: ["SwiftModelsBenchmarks"]),
        .library(name: "Checkpoints", targets: ["Checkpoints"]),
        .library(name: "Datasets", targets: ["Datasets"]),
        .library(name: "ModelSupport", targets: ["ModelSupport"]),
        .library(name: "TensorBoard", targets: ["TensorBoard"]),
        .library(name: "ImageClassificationModels", targets: ["ImageClassificationModels"]),
        .library(name: "VideoClassificationModels", targets: ["VideoClassificationModels"]),
        .library(name: "RecommendationModels", targets: ["RecommendationModels"]),
        .library(name: "TextModels", targets: ["TextModels"]),
        .library(name: "FastStyleTransfer", targets: ["FastStyleTransfer"]),
        .library(name: "MiniGo", targets: ["MiniGo"]),
        .library(name: "TrainingLoop", targets: ["TrainingLoop"]),
        .library(name: "pix2pix", targets: ["pix2pix"]),
        .library(name: "SwiftModelsBenchmarksCore", targets: ["SwiftModelsBenchmarksCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.10.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", branch: "main"),
        .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0"),
        .package(url: "https://github.com/thinkpractice/TaylorTorch.git", branch: "hip_support"),
    ],
    targets: [
        .target(
            name: "Checkpoints",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ModelSupport"
            ],
            path: "Checkpoints"),
        .target(
            name: "Datasets",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ModelSupport"
            ],
            path: "Datasets"),
        .target(name: "STBImage", path: "Support/STBImage"),
        .target(
            name: "ModelSupport",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "STBImage"
            ],
            path: "Support",
            exclude: ["STBImage"]
        ),
        .target(
            name: "TensorBoard",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ModelSupport",
                "TrainingLoop"
            ],
            path: "TensorBoard"),
        .target(
            name: "ImageClassificationModels",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Models/ImageClassification"),
        .target(
            name: "VideoClassificationModels",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Models/Spatiotemporal"),
        .target(
            name: "TextModels",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Checkpoints",
                "Datasets"
            ],
            path: "Models/Text"),
        .target(
            name: "RecommendationModels",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Models/Recommendation"),
        .target(
            name: "TrainingLoop",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ModelSupport"
            ],
            path: "TrainingLoop"),
        .executableTarget(
            name: "Autoencoder1D",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ModelSupport",
                "TrainingLoop",
                "AutoencoderCallback"
            ],
            path: "Autoencoder/Autoencoder1D"),
        .executableTarget(
            name: "Autoencoder2D",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ModelSupport"
            ],
            path: "Autoencoder/Autoencoder2D"),
        .executableTarget(
            name: "VariationalAutoencoder1D",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ModelSupport"
            ],
            path: "Autoencoder/VAE1D"),
        .target(
            name: "AutoencoderCallback",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ModelSupport",
                "TrainingLoop"
            ],
            path: "Autoencoder/Callback"),
        .executableTarget(
            name: "Catch",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Catch"),
        .executableTarget(
            name: "Gym-FrozenLake",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Gym/FrozenLake"),
        .executableTarget(
            name: "Gym-CartPole",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Gym/CartPole"),
        .executableTarget(
            name: "Gym-Blackjack",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Gym/Blackjack"),
        .executableTarget(
            name: "Gym-DQN",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Gym/DQN"),
        .executableTarget(
            name: "Gym-PPO",
            dependencies: [.product(name: "TaylorTorch", package: "taylortorch")],
            path: "Gym/PPO"),
        .executableTarget(
            name: "VGG-Imagewoof",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ImageClassificationModels",
                "TrainingLoop"
            ],
            path: "Examples/VGG-Imagewoof"),
        .executableTarget(
            name: "Regression-BostonHousing",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets"
            ],
            path: "Examples/Regression-BostonHousing"),
        .executableTarget(
            name: "Custom-CIFAR10",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets"
            ],
            path: "Examples/Custom-CIFAR10"),
        .executableTarget(
            name: "ResNet-CIFAR10",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ImageClassificationModels",
                "TrainingLoop"
            ],
            path: "Examples/ResNet-CIFAR10"),
        .executableTarget(
            name: "BigTransfer-CIFAR100",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ImageClassificationModels"
            ],
            path: "Examples/BigTransfer-CIFAR100"),
        .executableTarget(
            name: "Shallow-Water-PDE",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Benchmark", package: "swift-benchmark"),
                "ModelSupport"
            ],
            path: "Examples/Shallow-Water-PDE"),
        .executableTarget(
            name: "LeNet-MNIST",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ImageClassificationModels",
                "TrainingLoop"
            ],
            path: "Examples/LeNet-MNIST"),
        .executableTarget(
            name: "MobileNetV1-Imagenette",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ImageClassificationModels",
                "TrainingLoop"
            ],
            path: "Examples/MobileNetV1-Imagenette"),
        .executableTarget(
            name: "MobileNetV2-Imagenette",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ImageClassificationModels",
                "TrainingLoop"
            ],
            path: "Examples/MobileNetV2-Imagenette"),
        .executableTarget(
            name: "ResNet50-ImageNet",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ImageClassificationModels",
                "TrainingLoop",
                "TensorBoard"
            ],
            path: "Examples/ResNet50-ImageNet"),
        .executableTarget(
            name: "PersonLab",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Checkpoints", "ModelSupport",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "PersonLab"),
        .target(
            name: "MiniGo",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Checkpoints"
            ],
            path: "MiniGo",
            exclude: ["main.swift"]),
        .executableTarget(
            name: "MiniGoDemo",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "MiniGo"
            ],
            path: "MiniGo",
            sources: ["main.swift"]),
        .executableTarget(
            name: "NeuMF-MovieLens",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "RecommendationModels",
                "Datasets"
            ],
            path: "Examples/NeuMF-MovieLens"),
        .testTarget(
            name: "MiniGoTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "MiniGo"
            ]),
        .testTarget(
            name: "ImageClassificationTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ImageClassificationModels"
            ]),
        .testTarget(
            name: "VideoClassificationTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "VideoClassificationModels"
            ]),
        .testTarget(
            name: "RecommendationModelTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "RecommendationModels"
            ]),
        .testTarget(
            name: "DatasetsTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "TextModels"
            ]),
        .executableTarget(
            name: "GPT2-Inference",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "TextModels"
            ],
            path: "Examples/GPT2-Inference",
            exclude: ["UI/Windows/main.swift", "UI/macOS/main.swift"]),
        .executableTarget(
            name: "GPT2-WikiText2",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "TextModels",
                "TrainingLoop",
                "TensorBoard"
            ],
            path: "Examples/GPT2-WikiText2"),
        .testTarget(
            name: "TextTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "TextModels"
            ]),
        .executableTarget(
            name: "GAN",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ModelSupport"
            ],
            path: "GAN"),
        .executableTarget(
            name: "DCGAN",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ModelSupport"
            ],
            path: "DCGAN"),
        .target(
            name: "FastStyleTransfer",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Checkpoints"
            ],
            path: "FastStyleTransfer",
            exclude: ["Demo"]),
        .executableTarget(
            name: "FastStyleTransferDemo",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "FastStyleTransfer"
            ],
            path: "FastStyleTransfer/Demo"),
        .testTarget(
            name: "FastStyleTransferTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "FastStyleTransfer"
            ]),
        .target(
            name: "SwiftModelsBenchmarksCore",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets", "ModelSupport", "ImageClassificationModels",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "TextModels",
                .product(name: "Benchmark", package: "swift-benchmark"),
            ],
            path: "SwiftModelsBenchmarksCore"),
        .executableTarget(
            name: "SwiftModelsBenchmarks",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "SwiftModelsBenchmarksCore"
            ],
            path: "SwiftModelsBenchmarks"
        ),
        .testTarget(
            name: "CheckpointTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Checkpoints",
                "ImageClassificationModels"
            ]),
        .executableTarget(
            name: "BERT-CoLA",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "TextModels",
                "Datasets",
                "TrainingLoop"
            ],
            path: "Examples/BERT-CoLA"),
        .testTarget(
            name: "SupportTests",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ModelSupport"
            ]),
        .executableTarget(
            name: "CycleGAN",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ModelSupport",
                "Datasets"
            ],
            path: "CycleGAN"
        ),
        .target(
            name: "pix2pix",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "TaylorTorch", package: "taylortorch"),
                "ModelSupport",
                "Datasets",
                "Checkpoints"
            ],
            path: "pix2pix",
            exclude: ["main.swift"]
        ),
        .executableTarget(
            name: "pix2pixDemo",
            dependencies: [
                .product(name: "TaylorTorch", package: "taylortorch"),
                "pix2pix"
            ],
            path: "pix2pix",
            sources: ["main.swift"]
        ),
        .executableTarget(
            name: "WordSeg",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "TaylorTorch", package: "taylortorch"),
                "Datasets",
                "ModelSupport",
                "TextModels"
            ],
            path: "Examples/WordSeg"
        ),
        .executableTarget(
            name: "Fractals",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "ModelSupport"
            ],
            path: "Examples/Fractals"
        ),
        .executableTarget(
            name: "GrowingNeuralCellularAutomata",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "ModelSupport"
            ],
            path: "Examples/GrowingNeuralCellularAutomata"
        ),
    ]
)
