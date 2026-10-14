import Testing
@testable import ApplicationInspector

@Test func testLoadingOfAllApplications() async throws
{    
    let testApplicationInspector_allApps: ApplicationInspector = try await .init(excludeSystemApps: false)
    
    let testApplicationInspector_onlyUserApps: ApplicationInspector = try await .init(excludeSystemApps: true)
    
    #expect(testApplicationInspector_allApps.installedApplications.count > 0)
    #expect(testApplicationInspector_onlyUserApps.installedApplications.count > 0)
    
    #expect(testApplicationInspector_allApps.installedApplications.count > testApplicationInspector_onlyUserApps.installedApplications.count)
}

@Test func testLoadingOfAnApplication() async throws
{
    let testedApplication: Application = try .init(from: .init(filePath: "/System/Applications/Music.app"))
    
    #expect(testedApplication.name == "Music")
    #expect(testedApplication.url == .init(filePath: "/System/Applications/Music.app"))
    #expect(testedApplication.additionalDetails.bundleID == "com.apple.Music")
    #expect(testedApplication.additionalDetails.isSystemApp == true)
}

@Test func testLoadingOfIpadApplication() async throws
{
    let testedApplication: Application = try .init(from: .init(filePath: "/Applications/Rohlik.app"))
    
    print("Icon path for tested application \(testedApplication.name): \(testedApplication.iconPath)")
    
    #expect(testedApplication.name == "Rohlik")
    #expect(testedApplication.url == .init(filePath: "/Applications/Rohlik.app"))
    #expect(testedApplication.additionalDetails.bundleID == "cz.rohlik.rohlik")
    #expect(testedApplication.additionalDetails.isSystemApp == false)
    #expect(testedApplication.iconPath != nil)
    #expect(testedApplication.iconPath?.pathExtension == "icns" || testedApplication.iconPath?.pathExtension == "png")
}
