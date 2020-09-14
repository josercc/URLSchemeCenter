import XCTest
@testable import URLSchemeCenter

final class URLSchemeCenterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(URLSchemeCenter().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
