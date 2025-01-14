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
        let check_true = vc.canCreateTweet(tweet: "Hello World")
        let check_false = vc.canCreateTweet(tweet: "いまユーチューブ見てます。その動画に外国人からの英語のコメントがあると、なんか自分もワールドクラスになったような気がします。というわけで、ではみなさんは好きな英熟語は何か、ぜひ教えていただけたら幸いです。テスト用例文。いまユーチューブ見てます。その動画に外国人からの英語のコメントがあると、なんか自分もワールドクラスになったような気がします。というわけで、ではみなさんは好きな英熟語は何か、ぜひ教えていただけたら幸いです。テスト用例文。")
        
//      140文字以内の場合にtrueになるかチェック
        XCTAssertTrue(check_true)
//      140文字以上の場合にfalseになるかチェック
        XCTAssertFalse(check_false)
        

    }

}
