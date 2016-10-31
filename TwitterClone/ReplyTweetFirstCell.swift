//
//  ReplyTweetFirstCell.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 10/30/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class ReplyTweetFirstCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetNumberLabel: UILabel!
    @IBOutlet weak var favoritesNumberLabel: UILabel!
    
    
    @IBOutlet weak var onReplyButton: UIButton!
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance?.retweet(tweetId: tweet.id!, success: { (tweet: Tweet) in
            self.retweetNumberLabel.text = "\(tweet.retweetCount + 1)"
            
            }, failure: { (error: Error) in
                print("error: \(error.localizedDescription)")
        })
    }
    
    @IBAction func onFavoritesButton(_ sender: AnyObject) {
    }
    
    var tweet: Tweet! {
        didSet {
            guard tweet != nil else {
                return
            }
            
            tweetTextLabel.text = tweet.text
            //TODO
            // timeStampLabel.text = tweet.timestamp
            
            
            if let user = tweet.userInfo {
                userNameLabel.text = user.name
                screenNameLabel.text = user.screenName
                profileImageView.setImageWith(user.profileURL!)
            }
            
            retweetNumberLabel.text = "\(tweet.retweetCount)"
            
            favoritesNumberLabel.text = "\(tweet.favoritesCount)"
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
