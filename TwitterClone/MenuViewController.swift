//
//  MenuViewController.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 11/4/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var profileViewController: UIViewController!
    private var mentionsViewController: UIViewController!
    
    var viewControllers:[UIViewController] = []
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        let mentionsViewController = storyboard.instantiateViewController(withIdentifier: "MentionsViewController")
        
        viewControllers.append(profileViewController)
        viewControllers.append(mentionsViewController)
        
        hamburgerViewController.contentViewController = profileViewController
        // Do any additional setup after loading the view.
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

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        let titles = ["Profile", "Mentions"]
        
        cell.menuTitle.text = titles[indexPath.row]
        
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
}
