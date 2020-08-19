import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(material_icons_testTests.allTests),
    ]
}
#endif
