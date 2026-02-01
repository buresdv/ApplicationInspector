import Testing
@testable import ApplicationInspector

@Test func testLoadingOfAllApplications() async throws
{    
    let testApplicationInspector: ApplicationInspector = try await .init()
    
    #expect(testApplicationInspector.installedApplications.count > 0)
}

@Test func testLoadingOfAnApplication() async throws
{
    let testedApplication: Application = try .init(from: .init(filePath: "/System/Applications/Music.app"))
    
    #expect(testedApplication.name == "Music")
    #expect(testedApplication.url == .init(filePath: "/System/Applications/Music.app"))
}
