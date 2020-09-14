import XCTest
@testable import URLSchemeCenter

final class URLSchemeCenterTests: XCTestCase {
    func testExample() {
        URLSchemeCenter.center.register(seheme: DataCollect.self, {DataCollect()})
        URLSchemeCenter.center.router(url: "pineal://DataCollection/topic?name=1&age=3")
        URLSchemeCenter.center.router(url: "pineal://DataCollection/delete?id=1&name=3")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

struct DataCollect: URLScheme {
    static func urlSchemeActions() {
        self.addURLSchemeAction(path: "topic") { (collection, parameter) in
            print("topic \(parameter)")
        }
        self.addURLSchemeAction(path: "delete") { (collection, parameter) in
            print("delete \(parameter)")
        }
    }
    
    static var host: String {
        return "DataCollection"
    }
    
    
}
