//
//  UserNameAndPhoneNoViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/2/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit
import SinchVerification


class UserNameAndPhoneNoViewController: UIViewController {
    
    
    var verifiction:Verification!
    let applicationKey = "bf8eb31b-9519-4b73-82dc-3a3fa8b79d5e"
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    var overlayView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let greenColorGreen = Color.green
        userName.layer.borderColor = greenColorGreen.getColor().CGColor
        userName.layer.borderWidth = 1
        phoneNumber.layer.borderColor = greenColorGreen.getColor().CGColor
        phoneNumber.layer.borderWidth = 1
        phoneNumber.addTarget(self, action: #selector(UserNameAndPhoneNoViewController.formatPhoneNumber(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func formatPhoneNumber(sender:UITextField!) {
        
        var phNum = self.phoneNumber.text
        phNum = phNum!.stringByReplacingOccurrencesOfString("(", withString: "")
            .stringByReplacingOccurrencesOfString(")", withString: "")
            .stringByReplacingOccurrencesOfString("-", withString: "")
            .stringByReplacingOccurrencesOfString(" ", withString: "")
        let characterCount :Int  = (phNum?.characters.count)!
        
        switch  characterCount {
        case 4...6 :
            
            let formattedPhnumber = String(format: "(%@) %@",
                                           phNum!.substringWithRange(phNum!.startIndex ... phNum!.startIndex.advancedBy(2)),
                                           phNum!.substringWithRange(phNum!.startIndex.advancedBy(3) ... phNum!.endIndex.advancedBy(-1)))
            self.phoneNumber.text = formattedPhnumber
            break
        case 7...10 :
            
            
            let formattedPhnumber = String(format: "(%@) %@-%@",
                                           phNum!.substringWithRange(phNum!.startIndex ... phNum!.startIndex.advancedBy(2)),
                                           phNum!.substringWithRange(phNum!.startIndex.advancedBy(3) ... phNum!.startIndex.advancedBy(5)),
                                           phNum!.substringWithRange(phNum!.startIndex.advancedBy(6) ... phNum!.endIndex.advancedBy(-1)))
            self.phoneNumber.text = formattedPhnumber
            break
        case 11...1000 :
            
            
            let formattedPhnumber = String(format: "(%@) %@-%@",
                                           phNum!.substringWithRange(phNum!.startIndex ... phNum!.startIndex.advancedBy(2)),
                                           phNum!.substringWithRange(phNum!.startIndex.advancedBy(3) ... phNum!.startIndex.advancedBy(5)),
                                           phNum!.substringWithRange(phNum!.startIndex.advancedBy(6) ... phNum!.startIndex.advancedBy(9)))
            self.phoneNumber.text = formattedPhnumber
            break
            
        default:
            self.phoneNumber.text = phNum
            
            
        }
        
        
    }
    
    @IBAction func Continue(sender: AnyObject) {
        var phNum = self.phoneNumber.text
        phNum = phNum!.stringByReplacingOccurrencesOfString("(", withString: "")
            .stringByReplacingOccurrencesOfString(")", withString: "")
            .stringByReplacingOccurrencesOfString("-", withString: "")
            .stringByReplacingOccurrencesOfString(" ", withString: "")
        phNum =   "+1"+phNum!
        let characterCount :Int  = (phNum?.characters.count)!

        var spinner:loadingAnimation = loadingAnimation(overlayView:overlayView, senderView:self.view)
        spinner.showOverlay(1)
        verifiction = SMSVerification(applicationKey: applicationKey, phoneNumber: phNum!)
        verifiction.initiate { (Success:Bool, Error:NSError?) ->Void in
            if(Success){
               print(self.verifiction)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let verifyController = storyBoard.instantiateViewControllerWithIdentifier("VerifyPhoneNo") as! VerificationViewController
                verifyController.verifiction = self.verifiction
                self.presentViewController(verifyController, animated: true, completion: nil)
            
            }
            else{
               spinner.hideOverlayView()
            }
        }
        
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
