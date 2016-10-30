//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 10/29/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetView: UIView!
    @IBOutlet weak var retweetHandleLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            
            guard tweet != nil else {
                return
            }
            
            tweetTextLabel.text = tweet.text
            //TODO
           // timeStampLabel.text = tweet.timestamp
            
            
            if let user = tweet.userInfo {
                fullNameLabel.text = user.name
                userHandleLabel.text = user.screenName
                profileImageView.setImageWith(user.profileURL!)
            }
            
            if tweet.retweenCount == 0 {
                retweetView.isHidden = true
            }
            else {
                retweetHandleLabel.text = tweet.retweenCount as? String
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
