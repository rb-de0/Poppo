@testable import Poppo
import Foundation
import XCTest

class PoppoTests: XCTestCase {
    
    func testTweet() {
        
        guard let csKey = ProcessInfo.processInfo.environment["CONSUMER_KEY"],
            let csKeySecret = ProcessInfo.processInfo.environment["CONSUMER_KEY_SECRET"],
            let atKey = ProcessInfo.processInfo.environment["ACCESS_TOKEN_KEY"],
            let atKeySecret = ProcessInfo.processInfo.environment["ACCESS_TOKEN_SECRET"] else {
                
            return
        }
        
        let poppo = Poppo(consumerKey: csKey, consumerKeySecret: csKeySecret, accessToken: atKey, accessTokenSecret: atKeySecret)
        poppo.tweet(status: "chun")
    }
    
    static var allTests : [(String, (PoppoTests) -> () throws -> Void)] {
        return [
            ("testTweet", testTweet),
        ]
    }
}
