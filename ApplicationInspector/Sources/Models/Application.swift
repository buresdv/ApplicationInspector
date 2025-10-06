//
//  Application.swift
//  ApplicationInspector
//
//  Created by David Bureš - P on 06.10.2025.
//

import Foundation
import SwiftUI

public struct Application
{
    public let name: String
    
    public let iconPath: URL?
    
    public let iconImage: Image?

    public enum ApplicationInitializationError: LocalizedError
    {
        public enum MandatoryAppInformation: String
        {
            case name
            
            public var description: String
            {
                switch self {
                case .name:
                    return "Name"
                }
            }
        }
        
        case applicationExecutableNotReadable(checkedPath: String)
        case couldNotAccessApplicationExecutable(error: Error)
        case couldNotReadBundle(applicationPath: String)
        case couldNotGetInfoDictionary
        case couldNotGetMandatoryAppInformation(_ mandatoryInformation: MandatoryAppInformation)
        
        public var errorDescription: String?
        {
            switch self {
            case .applicationExecutableNotReadable(let checkedPath):
                return "Couldn't read application executable at \(checkedPath)"
            case .couldNotAccessApplicationExecutable(let error):
                return "Couldn't read application executable: \(error)"
            case .couldNotReadBundle(let applicationPath):
                return "Couldn't read application bundle at \(applicationPath)"
            case .couldNotGetInfoDictionary:
                return "Couldn't read application info.plist"
            case .couldNotGetMandatoryAppInformation(let mandatoryInformation):
                return "Couldn't read mandatory app information: \(mandatoryInformation.description)"
            }
        }
    }

    public init(from appURL: URL) throws(ApplicationInitializationError)
    {
        do
        {
            guard FileManager.default.isReadableFile(atPath: appURL.path) == true else
            {
                throw ApplicationInitializationError.applicationExecutableNotReadable(checkedPath: appURL.path)
            }

            guard let appBundle: Bundle = .init(url: appURL)
            else
            {
                throw ApplicationInitializationError.couldNotReadBundle(applicationPath: appURL.absoluteString)
            }

            LibraryConstants.shared.logger.debug("Will try to initialize and App object form bundle \(appBundle)")
            
            guard let appBundleInfoDictionary: [String: Any] = appBundle.infoDictionary
            else
            {
                throw ApplicationInitializationError.couldNotGetInfoDictionary
            }
            
            guard let appName: String = Application.getAppName(fromInfoDictionary: appBundleInfoDictionary) else
            {
                throw ApplicationInitializationError.couldNotGetMandatoryAppInformation(.name)
            }
            
            self.name = appName

            self.iconPath = Application.getAppIconPath(fromInfoDictionary: appBundleInfoDictionary, appBundle: appBundle)
            
            if let iconPath = self.iconPath
            {
                self.iconImage = .init(
                    nsImage: .init(byReferencing: iconPath)
                )
            }
            else
            {
                self.iconImage = nil
            }
        }
        catch let applicationDirectoryAccessError
        {
            throw .couldNotAccessApplicationExecutable(error: applicationDirectoryAccessError)
        }
    }

    private static func getAppName(fromInfoDictionary infoDictionary: [String: Any]) -> String?
    {
        return infoDictionary["CFBundleName"] as? String
    }
    
    private static func getAppIconPath(fromInfoDictionary infoDictionary: [String: Any], appBundle: Bundle) -> URL?
    {
        guard let iconFileName: String = infoDictionary["CFBundleIconFile"] as? String
        else
        {
            return nil
        }

        return appBundle.resourceURL?.appendingPathComponent(iconFileName, conformingTo: .icns)
    }
}
