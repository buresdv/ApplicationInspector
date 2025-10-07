import ApplicationInspector
import Foundation
import Testing

@Suite("Application Info Reading")
struct ApplicationInfoReadingSuite
{
    @Test("Test basic app properties reading")
    func testObjectPropertyReading() async throws
    {
        let systemApplication: Application = try .init(from: TestConstants.shared.testAppURL_systemApp)
        
        #expect(systemApplication.name == "Weather")
        
        let customApplication: Application = try .init(from: TestConstants.shared.testAppURL_customApp)
        
        #expect(customApplication.name == "Cork")
    }
    
    @Test("Test installed applications loading")
    func testInstalledAppsLoading() async throws
    {
        let applicationInspector: ApplicationInspector = .init()
        
        let parsedApplications_continueIfError: [Application] = try applicationInspector.loadAllApps(loadingBehavior: .continueIfError)
        
        #expect(!parsedApplications_continueIfError.isEmpty)
    }
}
