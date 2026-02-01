// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public typealias ApplicationsListingResult = Result<Application, Application.ApplicationInitializationError>

public class ApplicationInspector
{
    public var installedApplications: [ApplicationsListingResult]

    public init() async throws(ApplicationsDirectoryReadingError)
    {
        self.installedApplications = try await ApplicationInspector.getAllInstalledApplications()
    }

    public enum ApplicationsDirectoryReadingError: LocalizedError
    {
        case couldNotReadContentsOfApplicationsDirectory(error: Error)
    }
}
