import ProjectDescription

let project = Project(
    name: "ApplicationInspector",
    targets: [
        .target(
            name: "ApplicationInspector",
            destinations: .macOS,
            product: .staticLibrary,
            bundleId: "eu.davidbures.ApplicationInspector",
            deploymentTargets: .macOS("14.0.0"),
            infoPlist: .default,
            sources: ["ApplicationInspector/Sources/**"],
            resources: ["ApplicationInspector/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "ApplicationInspectorTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "eu.davidbures.ApplicationInspectorTests",
            deploymentTargets: .macOS("14.0.0"),
            infoPlist: .default,
            sources: ["ApplicationInspector/Tests/**"],
            resources: [],
            dependencies: [.target(name: "ApplicationInspector")]
        ),
    ]
)
