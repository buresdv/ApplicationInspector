//
//  Test Constants.swift
//  ApplicationInspectorTests
//
//  Created by David Bureš - P on 06.10.2025.
//

import Foundation

struct TestConstants
{
    static let shared: Self = .init()
    
    let testAppURL_systemApp: URL = .init(filePath: "/System/Applications/Weather.app")
    
    let testAppURL_customApp: URL = .init(filePath: "/Applications/Cork.app")
}
