//
//  TableViewCell.swift
//  TwitterSampleApp
//
//  Created by 髙坂澄怜 on 2024/12/10.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tweet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(name: String, tweet: String) {
        self.name.text = name
        self.tweet.text = tweet
    }
    
}
