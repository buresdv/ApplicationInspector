//
//  Load Installed Apps.swift
//  ApplicationInspector
//
//  Created by David Bureš - P on 06.10.2025.
//

import Foundation

public extension ApplicationInspector
{
    enum AllAppsLoadingError: LocalizedError
    {
        case couldNotReadContentsOfApplicationsFolder(error: String)

        public var errorDescription: String?
        {
            switch self
            {
            case .couldNotReadContentsOfApplicationsFolder(let error):
                return "Couldn't read contents of Applications folder: \(error)"
            }
        }
    }

    /// How the loader should behave if it encounters an error
    enum LoadingBehavior
    {
        /// Stop the function and fail
        case failIfError
        
        /// Ignore the error and continue without parsing that app
        case continueIfError
    }

    /// Read the contents of the `Applications` directory and return a parsed list of all installed apps
    func loadAllApps(loadingBehavior: LoadingBehavior) throws -> [Application]
    {
        do
        {
            let contentsOfApplicationsFolder: [URL] = try FileManager.default.contentsOfDirectory(at: URL.applicationDirectory, includingPropertiesForKeys: [.isExecutableKey], options: [.skipsHiddenFiles])

            var parsedApplications: [Application] = .init()

            for appUrl in contentsOfApplicationsFolder
            {
                do
                {
                    try parsedApplications.append(.init(from: appUrl))
                }
                catch let applicationParsingError
                {
                    switch loadingBehavior
                    {
                    case .failIfError:
                        throw applicationParsingError
                    case .continueIfError:
                        continue
                    }
                }
            }
            
            return parsedApplications
        }
        catch let applicationsDirectoryReadingError
        {
            throw AllAppsLoadingError.couldNotReadContentsOfApplicationsFolder(error: applicationsDirectoryReadingError.localizedDescription)
        }
    }
}
