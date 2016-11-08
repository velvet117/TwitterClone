//
//  ProfileCell.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 11/6/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var borderProfileImageView: UIImageView!
    var tweet: Tweet! {
        didSet {
            
            guard tweet != nil else {
                return
            }
            
            if let user = tweet.userInfo {
                
                profileImageView.setImageWith(user.profileURL!)
                
            }
            
        }
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 40
        
        borderProfileImageView.clipsToBounds = true
        borderProfileImageView.layer.cornerRadius = 45
        borderProfileImageView.backgroundColor = UIColor.white
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
