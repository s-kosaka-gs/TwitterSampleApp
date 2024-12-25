//
//  HomeBrewController.swift
//  TwitterSampleApp
//
//  Created by 髙坂澄怜 on 2024/11/29.
//

import Foundation
import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var tweetDataList: [TweetDataModel] = []
    
    override func viewDidLoad() {
        // UITableViewの罫線を表示
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        if #available(iOS 15.0, *) {
            tableView.fillerRowHeight = 50
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil ), forCellReuseIdentifier: "TableViewCell")
        self.tableView.estimatedRowHeight = 100
        
        setHomeButton()
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTweetData()
        tableView.reloadData()
        print("hoge")
    }
    
//  追加ボタン
    @IBAction func tappedAddButton(_ sender: UIButton) {
        transitionToEditView()
    }
    
//  データ取得
    func setTweetData() {
        let realm = try! Realm()
        let result = realm.objects(TweetDataModel.self)
        tweetDataList = Array(result)
        
    }
    
//　ホームボタンを配置
    func setHomeButton() {
        let buttonActionSelector: Selector = #selector(didTapHomeButton)
        let homeButtonImage = UIImage(named: "homeIcon")
        let homeButton = UIButton()
        homeButton.setImage(homeButtonImage, for: .normal)
        homeButton.addTarget(self, action: buttonActionSelector, for: .touchUpInside)
        
        navigationItem.titleView = homeButton
        
    }
    
    @objc func didTapHomeButton() {}
    
    func configureButton() {
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
    
    func transitionToEditView() {
        let storyboard = UIStoryboard(name: "TweetCreateViewController", bundle: nil)
        guard let createViewController = storyboard.instantiateInitialViewController() as? TweetCreateViewController else { return }
        createViewController.modalPresentationStyle = .fullScreen
        present(createViewController, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let tweetDataModel = tweetDataList[indexPath.row]
        cell.configure(name: tweetDataModel.name, tweet: tweetDataModel.text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let targetTweet = tweetDataList[indexPath.row]
        let realm = try! Realm()
        try! realm.write {
            realm.delete(targetTweet)
        }
        tweetDataList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 70
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetDetailViewController = storyboard.instantiateViewController(withIdentifier: "TweetDetailViewController") as! TweetDetailViewController
        let textData = tweetDataList[indexPath.row]
        tweetDetailViewController.configure(text: textData)
        tableView.deselectRow(at: indexPath, animated: true)
        tweetDetailViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(tweetDetailViewController, animated: true, completion: nil)
    }
}
