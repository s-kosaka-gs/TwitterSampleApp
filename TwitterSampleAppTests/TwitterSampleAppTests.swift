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
        let updatedText = vc.tweetField.text ?? ""
        let maxCharasetCount: Int = 140
        
        XCTAssertTrue(maxCharasetCount > updatedText.count)
        XCTAssertFalse(maxCharasetCount <= updatedText.count)

    }

}
