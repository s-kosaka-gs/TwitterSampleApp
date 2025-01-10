//
//  TwitterSampleAppTests.swift
//  TwitterSampleAppTests
//
//  Created by 髙坂澄怜 on 2024/11/27.
//

import XCTest
@testable import TwitterSampleApp

class exmpleTests: XCTestCase {

    func testExample() throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let vc = TweetCreateViewController()
        let check = vc.canCreateTweet(tweet: "Hello World")
        
//      140文字以内の場合にfalseになるかチェック
        XCTAssertFalse(check)
        
//      140文字超えた場合にtrueになるかチェック
        XCTAssertTrue(check)

    }

}
