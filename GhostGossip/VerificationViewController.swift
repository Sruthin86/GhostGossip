//
//  VerificationViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/3/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var VerifyCodeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let greenColorEnum = Color.green
        VerifyCodeTextField.layer.borderColor = greenColorEnum.getColor().CGColor
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
