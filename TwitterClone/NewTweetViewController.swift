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
    @IBOutlet weak var countdownTextField: UITextField!
    
    let countdownMax:Int = 140
    let placeholderText = "I am ready for your tweet :)"
    var user:User? = User.currentUser
    var successfulTweet: ((Tweet) -> ())?
    var replyTweet: Tweet?
    
    @IBAction func onCancelButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweetButton(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance?.postTweetWith(tweetText: self.tweetMessageTextView.text, replyId:0, success: { (newTweet: Tweet) in

            self.successfulTweet?(newTweet)
            
            self.dismiss(animated: true, completion: nil)
            
            }, failure: { (error:Error) in
                print(error.localizedDescription)
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetMessageTextView.delegate = self

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
        
        let countdown = countdownMax - tweetMessageTextView.text.characters.count
        self.countdownTextField.text = "\(countdown)"
        tweetMessageTextView.text = placeholderText
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

extension NewTweetViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.selectedRange = NSMakeRange(0, 0)
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
        let countdown = self.countdownMax - self.tweetMessageTextView.text.characters.count
        countdownTextField.text = "\(countdown)"
    
        if countdown < 0 {
            countdownTextField.textColor = UIColor.red
        }
        else {
            countdownTextField.textColor = UIColor.blue
        }
        
        return true
    }
}
