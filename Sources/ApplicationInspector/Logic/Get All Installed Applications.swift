//
//  File.swift
//  ApplicationInspector
//
//  Created by David Bureš - P on 01.02.2026.
//

import Foundation

public extension ApplicationInspector
{
    static func getAllInstalledApplications() async throws(ApplicationsDirectoryReadingError) -> [ApplicationsListingResult]
    {
        do
        {
            let contentsOfApplicationsFolder: [URL] = try FileManager.default.contentsOfDirectory(at: .applicationDirectory, includingPropertiesForKeys: [.isApplicationKey])

            let applicationsLoaderResult = await withTaskGroup(
                of: ApplicationsListingResult.self
            ) { applicationsLoader in
                for applicationURL in contentsOfApplicationsFolder
                {
                    applicationsLoader.addTask
                    {
                        do throws(Application.ApplicationInitializationError)
                        {
                            let initializedApplication: Application = try Application(from: applicationURL)

                            return .success(initializedApplication)
                        }
                        catch let applicationInitializationError
                        {
                            return .failure(applicationInitializationError)
                        }
                    }
                }
                
                var applicationsListingResults: [ApplicationsListingResult] = .init()
                
                for await result in applicationsLoader
                {
                    applicationsListingResults.append(result)
                }
                
                return applicationsListingResults
            }
            
            return applicationsLoaderResult
        }
        catch let applicationsDirectoryReadingError
        {
            LibraryConstants.shared.logger.error("Failed while reading contetns of Applications directory: \(applicationsDirectoryReadingError.localizedDescription)")

            throw .couldNotReadContentsOfApplicationsDirectory(error: applicationsDirectoryReadingError)
        }
    }
}
