//
//  MentionsViewController.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 11/4/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var user:User? = User.currentUser
    var tweets:[Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "GeneralTweetCell", bundle: nil), forCellReuseIdentifier: "generalTweetCell")
        
        TwitterClient.sharedInstance?.mentionsTimeline(success: { (tweets:[Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }, failure: { (error:Error) in
                print(error.localizedDescription)
        })
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
extension MentionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "generalTweetCell", for: indexPath) as! GeneralTweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension MentionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
