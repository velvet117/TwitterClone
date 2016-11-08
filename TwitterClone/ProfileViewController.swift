//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 11/4/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var user:User? = User.currentUser
    var tweets:[Tweet] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TwitterClient.sharedInstance?.userTimeline(screenName: (user?.screenName)!, success: { (tweets:[Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            }, failure: { (error:Error) in
                print(error.localizedDescription)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureProfileView()
    }
    
    private func configureProfileView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "GeneralTweetCell", bundle: nil), forCellReuseIdentifier: "generalTweetCell")
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

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : (tweets.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileCell
            
            cell.profileImageView.setImageWith((user?.profileURL)!)
            
            if let coverURL = user?.coverURL {
                cell.coverImageView.setImageWith(coverURL)
            }
            
            return cell
        }
        
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "generalTweetCell", for: indexPath) as! GeneralTweetCell
            
            cell.tweet = tweets[indexPath.row]
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 300
//        }
//        else {
//            return tableView.autoresizingMask
//        }
//    }
}
