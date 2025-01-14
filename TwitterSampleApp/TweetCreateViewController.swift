//
//  TweetCreateViewController.swift
//  TwitterSampleApp
//
//  Created by 髙坂澄怜 on 2024/12/04.
//

import UIKit
import RealmSwift

class TweetCreateViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var tweetField: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var warningText: UILabel!
    
    var tweetData = TweetDataModel()
    let maxCharasetCount: Int = 140
    
    override func viewDidLoad() {
        configurebutton()
        configureTweetField()
        setDoneButton()
        
        tweetField.delegate = self
    }
    
    func canCreateTweet(tweet: String) -> Bool {
        var check_tweet: Bool = true
        
        if tweet.count < maxCharasetCount {
            check_tweet = true
        } else {
            check_tweet = false
        }
        return check_tweet
    }
        
    func configurebutton() {
        postButton.layer.cornerRadius = postButton.frame.height / 2
    }
    
    func configureTweetField() {
        // tweetFieldのレイアウトを設定
        tweetField.layer.borderColor = UIColor.lightGray.cgColor
        tweetField.layer.borderWidth = 0.5
        tweetField.layer.cornerRadius = 5
    }
    
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        nameField.inputAccessoryView = toolBar
        tweetField.inputAccessoryView = toolBar
    }
    
//  投稿ボタン
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        saveData()
    }
//  キャンセルボタン
    @IBAction func tappedCancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func saveData() {
        let realm = try! Realm()
        try! realm.write {
            tweetData.name = nameField.text ?? ""
            tweetData.text = tweetField.text ?? ""
            realm.add(tweetData)
        }
        print("name: \(tweetData.name)")
        dismiss(animated: true)
    }
    
}

extension TweetCreateViewController: UITextViewDelegate {
    // 入力した文字を保存・140文字の制限
    func textViewDidChange(_ tweetField: UITextView) {
        let updatedText = tweetField.text ?? ""
        var check_count: Bool = true
        
        check_count = canCreateTweet(tweet: updatedText)
        
        if check_count {
            let warningText = ""
            self.warningText.text = warningText
            postButton.isEnabled = true
            postButton.backgroundColor = .systemBlue
        } else {
            let warningText = "\(maxCharasetCount)文字以内で入力してください"
            self.warningText.text = warningText
            self.warningText.textColor = .red
            postButton.isEnabled = false
            postButton.backgroundColor = .gray
        }
    }
}
