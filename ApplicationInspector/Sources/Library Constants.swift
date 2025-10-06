//
//  Library Constants.swift
//  ApplicationInspector
//
//  Created by David Bureš - P on 06.10.2025.
//

import Foundation
import OSLog

public struct LibraryConstants
{
    public static let shared: Self = .init()
    
    public let logger: Logger = .init(subsystem: "eu.davidbures.application-inspector", category: "general")
}
