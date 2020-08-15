import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FinalExamV2Tests.allTests),
    ]
}
#endif
