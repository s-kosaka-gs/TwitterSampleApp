//
//  TweetDataModel.swift
//  TwitterSampleApp
//
//  Created by 髙坂澄怜 on 2024/11/29.
//

import Foundation
import RealmSwift

class TweetDataModel: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var text: String = ""
}
