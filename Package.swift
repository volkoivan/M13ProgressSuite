// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "M13ProgressSuite",
    // Минимальные версии, которые реальный код уже и так поддерживает
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11)
    ],
    products: [
        // Будет подключаться в виде `import M13ProgressSuite`
        .library(
            name: "M13ProgressSuite",
            targets: ["M13ProgressSuite"]
        )
    ],
    targets: [
        // Основная цель с исходниками Objective-C
        .target(
            name: "M13ProgressSuite",
            // Папка, где сейчас лежат *.m/ *.h (ничего переносить не нужно)
            path: "Classes",
            // SPM-у нужно знать, где «публичные» хедеры
            publicHeadersPath: ".",
            cSettings: [
                // Вдруг внутри есть #import <something/…> — на всякий случай
                .headerSearchPath("."),
                // Можно убрать, но полезно, если хотите условную компиляцию
                .define("M13PROGRESS_SUITE_SPM")
            ]
            // Если в репозитории есть картинки или xib’ы,
            // добавьте resources: [.process("Resources")]
        ),

        // Необязательные тесты — если хотите запускать их из SPM
        .testTarget(
            name: "M13ProgressSuiteTests",
            dependencies: ["M13ProgressSuite"],
            path: "M13ProgressSuiteTests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
