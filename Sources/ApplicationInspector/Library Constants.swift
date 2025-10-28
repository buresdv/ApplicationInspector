//
//  File.swift
//  ApplicationInspector
//
//  Created by David Bureš - P on 28.10.2025.
//

import Foundation
import OSLog

public final class LibraryConstants: Sendable
{
    static let shared: LibraryConstants = .init()
    
    let logger: Logger
    
    init()
    {
        self.logger = .init(subsystem: "eu.davidbures.application-inspector", category: "general")
    }
}
