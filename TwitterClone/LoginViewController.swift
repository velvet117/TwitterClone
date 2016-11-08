//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Anastasia Blodgett on 10/26/16.
//  Copyright © 2016 Anastasia Blodgett. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.login(success: {() -> ()  in
            self.performSegue(withIdentifier: "toHamburgerVCSegue", sender: nil)
            }, failure: {(error: Error) -> () in
                print("Login Error: \(error.localizedDescription)")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHamburgerVCSegue" {
            let hamburgerViewController = segue.destination as! HamburgerViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            menuViewController.hamburgerViewController = hamburgerViewController
            hamburgerViewController.menuViewController = menuViewController
        }
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
