//
//  GeneralTweetCell.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 11/6/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class GeneralTweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            
            guard tweet != nil else {
                return
            }
            
            tweetLabel.text = tweet.text
            timestampLabel.text = tweet.displayTimeSinceCreated
            
            //retweet count
            if tweet.retweetCount == 0 {
                retweetCountLabel.text = ""
            }
            else {
                retweetCountLabel.text = "\(tweet.retweetCount)"
            }
            
            //favorites count
            if tweet.favoritesCount == 0 {
                favoriteCountLabel.text = ""
            }
            else {
                favoriteCountLabel.text = "\(tweet.favoritesCount)"
            }
            
            if let user = tweet.userInfo {
                fullNameLabel.text = user.name
                
                if let screenName = user.screenName {
                    handleLabel.text = "@\(screenName)"
                }
                
                profileImage.setImageWith(user.profileURL!)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
