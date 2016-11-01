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
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func onRetweetButton(_ sender: AnyObject) {
        
        if tweet.retweeted! {
            self.retweetButton.alpha = 1
            self.retweetNumberLabel.text = "\(tweet.retweetCount)"
            tweet.retweeted = false
            
            TwitterClient.sharedInstance?.unretweet(tweetId: tweet.id!, success: { (tweet: Tweet) in
                print("I have unretweeted")
                
                }, failure: { (error: Error) in
                    print("error: \(error.localizedDescription)")
            })
        }
        else {
            self.retweetNumberLabel.text = "\(tweet.retweetCount + 1)"
            self.retweetButton.alpha = 0.4
            tweet.retweeted = true
            
            TwitterClient.sharedInstance?.retweet(tweetId: tweet.id!, success: { (tweet: Tweet) in
                print("I have retweeted")
                
                }, failure: { (error: Error) in
                    
            })
        }
    }
    
    @IBAction func onFavoritesButton(_ sender: AnyObject) {
        
        if tweet.favorited! {
            self.favoritesNumberLabel.text = "\(tweet.favoritesCount)"
            self.favoriteButton.alpha = 1
            tweet.favorited = false
            
            TwitterClient.sharedInstance?.unfavorite(tweetId: tweet.id!, success: { (tweet: Tweet) in
                
                }, failure: { (error:Error) in
                    print("error: \(error.localizedDescription)")
            })
        }
        else {
            self.favoritesNumberLabel.text = "\(tweet.favoritesCount + 1)"
            self.favoriteButton.alpha = 0.4
            tweet.favorited = true
            
            TwitterClient.sharedInstance?.addFavorite(tweetId: tweet.id!, success: { (tweet: Tweet) in
                print("I have favoreted")
                
                }, failure: { (error: Error) in
                    print("error: \(error.localizedDescription)")
            })
        }
    }
    
    var tweet: Tweet! {
        didSet {
            guard tweet != nil else {
                return
            }
            
            tweetTextLabel.text = tweet.text
            timeStampLabel.text = "Created: \(tweet.displayTimeSinceCreated) ago"
            
            if let user = tweet.userInfo {
                userNameLabel.text = user.name
                
                if let screenName = user.screenName {
                    screenNameLabel.text = "@\(screenName)"
                }
                
                profileImageView.setImageWith(user.profileURL!)
            }
            
            retweetNumberLabel.text = "\(tweet.retweetCount)"
            
            favoritesNumberLabel.text = "\(tweet.favoritesCount)"
            
            if tweet.retweeted! {
                retweetButton.alpha = 0.4
            }
            
            if tweet.favorited! {
                favoriteButton.alpha = 0.4
            }
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
