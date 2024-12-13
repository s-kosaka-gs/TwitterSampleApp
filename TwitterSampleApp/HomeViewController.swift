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
    }
    
//  追加ボタン
    @IBAction func tappedAddButton(_ sender: UIButton) {
        transitionToEditView()
    }
    
//  ダミーデータ
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
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 70
        return UITableView.automaticDimension
    }
}
