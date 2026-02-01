// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public typealias ApplicationsListingResult = Result<Application, Application.ApplicationInitializationError>

public class ApplicationInspector
{
    public var installedApplications: [ApplicationsListingResult]

    public init(
        excludeSystemApps: Bool
    ) async throws(ApplicationsDirectoryReadingError)
    {
        self.installedApplications = try await ApplicationInspector.getAllInstalledApplications(
            excludeSystemApps: excludeSystemApps
        )
    }

    public enum ApplicationsDirectoryReadingError: LocalizedError
    {
        case couldNotReadContentsOfApplicationsDirectory(error: Error)
    }
}
