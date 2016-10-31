//
//  TwitterClient.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 10/28/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?

    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "9207x5BdjRm7kUbci7EcZGEWo", consumerSecret: "Dz0vMEgEkSCkdfJdjLKGU8rr2D3YWwMbwNFEPNNDruogiqA43s")
    
    func login(success: @escaping ()->(), failure: @escaping(Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"twitterclone://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("i got a token")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
            
        }) { (error: Error?) in
            print("error block in oath \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
    
    func logout() {
        
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenURL(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            print("i got the access token")
            
            self.currentAccount(success: { (user: User) in
                
                User.currentUser = user
                self.loginSuccess?()
                
            }, failure: { (error: Error) in
                self.loginFailure?(error)
            })
            
        }) { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
        print(url.description)
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any) in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
                
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("hometimeline \(response)")
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }
    
    func postTweet(success: @escaping (Tweet) -> (), failure: @escaping (Error) -> (), tweetText:String) {
        
        post("1.1/statuses/update.json", parameters: ["status": tweetText], progress: nil, success: { (task:URLSessionDataTask, response: Any?) in

            let tweet = Tweet(dictionary: response as! NSDictionary)
            
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        }
    }
    
    func retweet(tweetId: Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        post("1.1/statuses/retweet/\(tweetId).json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask, response: Any?) in
                
        }) { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        }
    }
    
    func addFavorite(tweetId:Int, success: @escaping (Tweet) -> (), failure: @escaping (Error) -> ()) {
        
        post("1.1/favorites/create.json", parameters: ["id": tweetId], progress: nil,
             success: { (task:URLSessionDataTask, response: Any?) in
                
        }) { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        }
    }
}
