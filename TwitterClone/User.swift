//
//  User.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 10/27/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenName: String?
    var profileURL: URL?
    var coverURL: URL?
    var postedTweetsCount: Int?
    var tagLine: String?
    
    var dictionary:NSDictionary!
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        postedTweetsCount = dictionary["statuses_count"] as? Int
        let profileURLString = dictionary["profile_image_url_https"] as? String
        let coverURLString = dictionary["profile_banner_url"] as? String
        
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
        }
        if let coverURLString = coverURLString {
            coverURL = URL(string: coverURLString)
        }
        
        tagLine = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    
    //Computed properties
    class var currentUser:User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }
            else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            
            defaults.synchronize()
        }
    }
}
