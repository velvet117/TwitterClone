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
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var tweetCountLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var borderProfileImageView: UIImageView!
    
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
