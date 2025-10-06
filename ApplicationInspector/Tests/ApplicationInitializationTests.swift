import ApplicationInspector
import Foundation
import Testing

@Suite("Application Initialization")
struct ApplicationInitializationTests
{
    @Test func testObjectInitialization() async throws
    {
        let _: Application = try .init(from: TestConstants.shared.testAppURL_systemApp)

        let _: Application = try .init(from: TestConstants.shared.testAppURL_customApp)
    }
}
