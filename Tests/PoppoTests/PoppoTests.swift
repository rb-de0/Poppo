import XCTest
@testable import Poppo

class PoppoTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Poppo().text, "Hello, World!")
    }


    static var allTests : [(String, (PoppoTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
