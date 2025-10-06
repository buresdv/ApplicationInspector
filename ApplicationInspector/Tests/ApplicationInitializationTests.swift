import ApplicationInspector
import Foundation
import Testing

@Suite("Application Initialization")
struct ApplicationInitializationTests
{
    @Test("Test basic application object initialization")
    func testObjectInitialization() async throws
    {
        let _: Application = try .init(from: TestConstants.shared.testAppURL_systemApp)

        let _: Application = try .init(from: TestConstants.shared.testAppURL_customApp)
    }
    
    @Test("Test application icon retrieval")
    func testApplicationIconRetrieval() async throws
    {
        let systemApplication: Application = try .init(from: TestConstants.shared.testAppURL_systemApp)
        
        let customApplication: Application = try .init(from: TestConstants.shared.testAppURL_customApp)
        
        #expect(systemApplication.iconPath != nil)
        
        #expect(customApplication.iconPath != nil)
        
        #expect(systemApplication.iconPath!.path == "/System/Applications/Weather.app/Contents/Resources/AppIcon.icns")
        
        #expect(customApplication.iconPath!.path == "/Applications/Cork.app/Contents/Resources/AppIcon.icns")
    }
}
