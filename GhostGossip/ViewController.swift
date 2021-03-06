//
//  ViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 7/29/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController  {


    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let  user = user {
                let uid = user.uid
                NSUserDefaults.standardUserDefaults().setObject(uid, forKey: fireBaseUid)
                let storyboard : UIStoryboard = UIStoryboard.init(name: "Dashboard", bundle: nil)
                let tabViewController :UIViewController =  storyboard.instantiateViewControllerWithIdentifier("MainTabView") as! MainTabBarViewController
                self.presentViewController(tabViewController, animated: true, completion: nil)
               

                
                // User is signed in.
            } else {
                                // No user is signed in.
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
    @IBAction func btnFBLoginPressed(sender: AnyObject) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("FBLoginLoading") as! FBLoadingViewController
        self.presentViewController(vc, animated:true, completion:nil)
    
    }

   
    
}

