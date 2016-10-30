//
//  TweetsViewController.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 10/29/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit
import AASquaresLoading

class TweetsViewController: UIViewController {

    var tweets:[Tweet] = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance?.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading(stopTime: 1.5)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(refreshControl:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        tableView.dataSource = self
        
//        tableView.estimatedRowHeight = 150
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) in
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
    
    private func showLoading(stopTime: TimeInterval) {
        self.view.squareLoading.start(0.0)
        self.view.squareLoading.setSquareSize(60)
        self.view.squareLoading.color = UIColor.twitterLightBlue
        self.view.squareLoading.stop(stopTime)
    }
    
    func refreshData(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            
            }, failure: { (error:Error) in
                print(error.localizedDescription)
        })
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

extension TweetsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
}


