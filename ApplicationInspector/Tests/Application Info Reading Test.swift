import ApplicationInspector
import Foundation
import Testing

@Suite("Application Info Reading")
struct ApplicationInfoReadingSuite
{
    @Test func testObjectPropertyReading() async throws
    {
        let systemApplication: Application = try .init(from: TestConstants.shared.testAppURL_systemApp)
        
        #expect(systemApplication.name == "Weather")
        
        let customApplication: Application = try .init(from: TestConstants.shared.testAppURL_customApp)
        
        #expect(customApplication.name == "Cork")
    }
}
