//
//  UserNameAndPhoneNoViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/2/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit


class UserNameAndPhoneNoViewController: UIViewController {

    
    let myColor : UIColor = UIColor( red: 0.00, green: 0.65, blue:0.47, alpha: 1.0 )
   
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         userName.layer.borderColor = myColor.CGColor
         userName.layer.borderWidth = 1
         phoneNumber.layer.borderColor = myColor.CGColor
         phoneNumber.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
