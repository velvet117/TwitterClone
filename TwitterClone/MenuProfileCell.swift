//
//  MenuProfileCell.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 11/6/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class MenuProfileCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
