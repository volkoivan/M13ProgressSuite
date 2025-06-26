// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "M13ProgressSuite",
    platforms: [
        .iOS(.v11),         // библиотека исторически работает с iOS 7+, но SPM начинается с 11
        .tvOS(.v11),
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "M13ProgressSuite",
            targets: ["M13ProgressSuite"])
    ],
    targets: [
        // ⬇︎ Основная цель с Objective-C-кодом
        .target(
            name: "M13ProgressSuite",
            path: "Classes",              // там лежат все .m/.h
            publicHeadersPath: ".",       // экспортируем всё, что в `Classes`
            cSettings: [
                // рекурсивно подхватываем сабдиректории
                .headerSearchPath("**"),
                .define("M13PROGRESS_SUITE_SPM")
            ],
            resources: [
                // в коде используются картинки для README/HUD
                .process("../ReadmeResources")
            ]
        ),

        // ⬇︎ необязательно; подключит unit-тесты, если они нужны
        .testTarget(
            name: "M13ProgressSuiteTests",
            path: "M13ProgressSuiteTests",
            dependencies: ["M13ProgressSuite"])
    ],
    swiftLanguageVersions: [.v5]
)
