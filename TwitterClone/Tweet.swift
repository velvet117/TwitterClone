//
//  Tweet.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 10/27/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var userInfo: User?
    var id:Int?
 
    init(dictionary: NSDictionary) {
        
        id = (dictionary["id"] as? Int) ?? 0
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.locale = NSLocale.init(localeIdentifier: "en_US_POSIX") as Locale!
            formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
            self.timestamp = formatter.date(from: timestampString)
        }
        
        if let userDictionary = dictionary["user"] {
            userInfo = User(dictionary: userDictionary as! NSDictionary)
        }
    }
    
    var displayTimeSinceCreated: String {
        if let timestamp = self.timestamp {
            let dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfYear,.day,.hour,.minute,.second]
            dateComponentsFormatter.maximumUnitCount = 1
            dateComponentsFormatter.unitsStyle = .abbreviated
            return dateComponentsFormatter.string(from: timestamp, to: Date()) ?? ""
        }
        return ""
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            print(dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
