//
//  TweetDetailViewController.swift
//  TwitterSampleApp
//
//  Created by 髙坂澄怜 on 2024/12/23.
//

import UIKit
import RealmSwift

class TweetDetailViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var warningText: UILabel!
    
    var tweetData = TweetDataModel()
    let maxCharasetCount: Int = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        configurebutton()
        configureTweetView()
        
        tweetView.delegate = self
    }
    
    func configure(text: TweetDataModel) {
        tweetData = text
        print("データは\(tweetData.text)と\(tweetData.name)です")
    }
    
    func configurebutton() {
        postButton.layer.cornerRadius = postButton.frame.height / 2
    }
    
    func configureTweetView() {
        // tweetFieldのレイアウトを設定
        tweetView.layer.borderColor = UIColor.lightGray.cgColor
        tweetView.layer.borderWidth = 0.5
        tweetView.layer.cornerRadius = 5
    }
    
//  確定ボタン
    @IBAction func addButton(_ sender: UIButton) {
        saveData()
    }
    
//  キャンセルボタン
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    func displayData() {
        nameField.text = tweetData.name
        tweetView.text = tweetData.text
    }
    
    func saveData(){
        let realm = try! Realm()
        try! realm.write {
            tweetData.name = nameField.text ?? ""
            tweetData.text = tweetView.text ?? ""
            realm.add(tweetData)
        }
        print("name: \(tweetData.name)")
        dismiss(animated: true)
    }
}

extension TweetDetailViewController: UITextViewDelegate {
    // 入力した文字を保存・140文字の制限
    func textViewDidChange(_ tweetField: UITextView) {
        let updatedText = tweetView.text ?? ""
        
        if updatedText.count > maxCharasetCount {
            let warningText = "\(maxCharasetCount)文字以内で入力してください"
            self.warningText.text = warningText
            self.warningText.textColor = .red
            postButton.isEnabled = false
            postButton.backgroundColor = .gray
        } else {
            let warningText = ""
            self.warningText.text = warningText
            postButton.isEnabled = true
            postButton.backgroundColor = .systemBlue
        }
    }
}
