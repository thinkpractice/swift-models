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
            name: "Checkpoints", dependencies: ["SwiftProtobuf", "ModelSupport"],
            path: "Checkpoints"),
        .target(name: "Datasets", dependencies: ["ModelSupport"], path: "Datasets"),
        .target(name: "STBImage", path: "Support/STBImage"),
        .target(
            name: "ModelSupport", dependencies: ["STBImage"], path: "Support", exclude: ["STBImage"]
        ),
        .target(
            name: "TensorBoard", dependencies: ["SwiftProtobuf", "ModelSupport", "TrainingLoop"],
            path: "TensorBoard"),
        .target(name: "ImageClassificationModels", path: "Models/ImageClassification"),
        .target(name: "VideoClassificationModels", path: "Models/Spatiotemporal"),
        .target(
            name: "TextModels",
            dependencies: ["Checkpoints", "Datasets", "SwiftProtobuf"],
            path: "Models/Text"),
        .target(name: "RecommendationModels", path: "Models/Recommendation"),
        .target(name: "TrainingLoop", dependencies: ["ModelSupport"], path: "TrainingLoop"),
        .executableTarget(
            name: "Autoencoder1D",
            dependencies: ["Datasets", "ModelSupport", "TrainingLoop", "AutoencoderCallback"],
            path: "Autoencoder/Autoencoder1D"),
        .executableTarget(
            name: "Autoencoder2D", dependencies: ["Datasets", "ModelSupport"],
            path: "Autoencoder/Autoencoder2D"),
        .executableTarget(
            name: "VariationalAutoencoder1D", dependencies: ["Datasets", "ModelSupport"],
            path: "Autoencoder/VAE1D"),
        .target(
            name: "AutoencoderCallback", dependencies: ["ModelSupport", "TrainingLoop"],
            path: "Autoencoder/Callback"),
        .executableTarget(name: "Catch", path: "Catch"),
        .executableTarget(name: "Gym-FrozenLake", path: "Gym/FrozenLake"),
        .executableTarget(name: "Gym-CartPole", path: "Gym/CartPole"),
        .executableTarget(name: "Gym-Blackjack", path: "Gym/Blackjack"),
        .executableTarget(name: "Gym-DQN", path: "Gym/DQN"),
        .executableTarget(name: "Gym-PPO", path: "Gym/PPO"),
        .executableTarget(
            name: "VGG-Imagewoof",
            dependencies: ["Datasets", "ImageClassificationModels", "TrainingLoop"],
            path: "Examples/VGG-Imagewoof"),
        .executableTarget(
            name: "Regression-BostonHousing", dependencies: ["Datasets"],
            path: "Examples/Regression-BostonHousing"),
        .executableTarget(
            name: "Custom-CIFAR10", dependencies: ["Datasets"],
            path: "Examples/Custom-CIFAR10"),
        .executableTarget(
            name: "ResNet-CIFAR10",
            dependencies: ["Datasets", "ImageClassificationModels", "TrainingLoop"],
            path: "Examples/ResNet-CIFAR10"),
        .executableTarget(
            name: "BigTransfer-CIFAR100",
            dependencies: ["Datasets", "ImageClassificationModels"],
            path: "Examples/BigTransfer-CIFAR100"),
        .executableTarget(
            name: "Shallow-Water-PDE",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Benchmark", package: "swift-benchmark"),
                "ModelSupport"
            ],
            path: "Examples/Shallow-Water-PDE"),
        .executableTarget(
            name: "LeNet-MNIST",
            dependencies: ["Datasets", "ImageClassificationModels", "TrainingLoop"],
            path: "Examples/LeNet-MNIST"),
        .executableTarget(
            name: "MobileNetV1-Imagenette",
            dependencies: ["Datasets", "ImageClassificationModels", "TrainingLoop"],
            path: "Examples/MobileNetV1-Imagenette"),
        .executableTarget(
            name: "MobileNetV2-Imagenette",
            dependencies: ["Datasets", "ImageClassificationModels", "TrainingLoop"],
            path: "Examples/MobileNetV2-Imagenette"),
        .executableTarget(
            name: "ResNet50-ImageNet",
            dependencies: ["Datasets", "ImageClassificationModels", "TrainingLoop", "TensorBoard"],
            path: "Examples/ResNet50-ImageNet"),
        .executableTarget(
            name: "PersonLab",
            dependencies: [
                "Checkpoints", "ModelSupport",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "PersonLab"),
        .target(
            name: "MiniGo", dependencies: ["Checkpoints"], path: "MiniGo", exclude: ["main.swift"]),
        .executableTarget(
            name: "MiniGoDemo", dependencies: ["MiniGo"], path: "MiniGo", sources: ["main.swift"]),
        .executableTarget(
            name: "NeuMF-MovieLens", dependencies: ["RecommendationModels", "Datasets"],
            path: "Examples/NeuMF-MovieLens"),
        .testTarget(name: "MiniGoTests", dependencies: ["MiniGo"]),
        .testTarget(name: "ImageClassificationTests", dependencies: ["ImageClassificationModels"]),
        .testTarget(name: "VideoClassificationTests", dependencies: ["VideoClassificationModels"]),
        .testTarget(name: "RecommendationModelTests", dependencies: ["RecommendationModels"]),
        .testTarget(name: "DatasetsTests", dependencies: ["Datasets", "TextModels"]),
        .executableTarget(
            name: "GPT2-Inference", dependencies: ["TextModels"],
            path: "Examples/GPT2-Inference",
            exclude: ["UI/Windows/main.swift", "UI/macOS/main.swift"]),
        .executableTarget(
            name: "GPT2-WikiText2",
            dependencies: ["Datasets", "TextModels", "TrainingLoop", "TensorBoard"],
            path: "Examples/GPT2-WikiText2"),
        .testTarget(name: "TextTests", dependencies: ["TextModels"]),
        .executableTarget(name: "GAN", dependencies: ["Datasets", "ModelSupport"], path: "GAN"),
        .executableTarget(name: "DCGAN", dependencies: ["Datasets", "ModelSupport"], path: "DCGAN"),
        .target(
            name: "FastStyleTransfer", dependencies: ["Checkpoints"], path: "FastStyleTransfer",
            exclude: ["Demo"]),
        .executableTarget(
            name: "FastStyleTransferDemo", dependencies: ["FastStyleTransfer"],
            path: "FastStyleTransfer/Demo"),
        .testTarget(name: "FastStyleTransferTests", dependencies: ["FastStyleTransfer"]),
        .target(
            name: "SwiftModelsBenchmarksCore",
            dependencies: [
                "Datasets", "ModelSupport", "ImageClassificationModels",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "TextModels",
                .product(name: "Benchmark", package: "swift-benchmark"),
            ],
            path: "SwiftModelsBenchmarksCore"),
        .executableTarget(
            name: "SwiftModelsBenchmarks",
            dependencies: ["SwiftModelsBenchmarksCore"],
            path: "SwiftModelsBenchmarks"
        ),
        .testTarget(
            name: "CheckpointTests", dependencies: ["Checkpoints", "ImageClassificationModels"]),
        .executableTarget(
            name: "BERT-CoLA", dependencies: ["TextModels", "Datasets", "TrainingLoop"],
            path: "Examples/BERT-CoLA"),
        .testTarget(name: "SupportTests", dependencies: ["ModelSupport"]),
        .executableTarget(
            name: "CycleGAN",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "ModelSupport",
                "Datasets"
            ],
            path: "CycleGAN"
        ),
        .target(
            name: "pix2pix",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "ModelSupport",
                "Datasets",
                "Checkpoints"
            ],
            path: "pix2pix",
            exclude: ["main.swift"]
        ),
        .executableTarget(
            name: "pix2pixDemo", dependencies: ["pix2pix"], path: "pix2pix", sources: ["main.swift"]
        ),
        .executableTarget(
            name: "WordSeg",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
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
