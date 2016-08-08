//
//  ProfileViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/7/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController {
    var uid :String?

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var fullName: UILabel!
    
    override func viewDidLoad() {
        uid = NSUserDefaults.standardUserDefaults().objectForKey(fireBaseUid) as! String
        let databaseRef = FIRDatabase.database().reference()
        profileImage.layer.cornerRadius  = self.profileImage.frame.width/2
        profileImage.clipsToBounds = true;
        
        databaseRef.child("Users").child(uid!).observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            
            let userDetails = snapshot.value as! [String: AnyObject]
            self.fullName.text =  userDetails["displayName"] as! String;
            let fileUrl = NSURL(string: userDetails["highResPhoto"] as! String)
            var profilePicUrl = NSData(contentsOfURL:  fileUrl!)
            self.profileImage.image = UIImage(data: profilePicUrl!)
            
        })
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
