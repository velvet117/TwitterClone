//
//  NewTweetViewController.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 10/30/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var tweetMessageTextView: UITextView!
    
    var user:User? = User.currentUser
    var successfulTweet: ((Tweet) -> ())?
    
    @IBAction func onCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweetButton(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance?.postTweet(success: { (newTweet: Tweet) in

            self.successfulTweet?(newTweet)
            
            self.dismiss(animated: true, completion: nil)
            
            }, failure: { (error:Error) in
                print(error.localizedDescription)
            }, tweetText: self.tweetMessageTextView.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.userProfileImageView.layer.cornerRadius = 3
        self.userProfileImageView.clipsToBounds = true
    }
    
    private func configureView() {
        
        guard let userInfo = user else {
            return
        }
        
        userNameLabel.text = userInfo.name
        
        if let screenName = userInfo.screenName {
            userHandleLabel.text = "@\(screenName)"
        }
        
        userProfileImageView.setImageWith(userInfo.profileURL!)
        
        tweetMessageTextView.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
