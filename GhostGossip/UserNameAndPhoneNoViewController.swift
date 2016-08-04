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
    
    
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
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
        
        //        var defaultRegion: String = SINDeviceRegion.currentCountryCode()
        //        var parseError: NSError? = nil
        //        var phoneNumber: SINPhoneNumber = try! SINPhoneNumberUtil().parse(self.phoneNumber.text!, defaultRegion: defaultRegion)
        //        if !phoneNumber {
        //            // Handle invalid user input
        //            // Handle invalid user input
        //        }
        //        var phoneNumberInE164: String = SINPhoneNumberUtil().formatNumber(phoneNumber, format: SINPhoneNumberFormatE164)
        //        var verification: SINVerification = SINVerification.SMSVerificationWithApplicationKey("<application key>", phoneNumber: phoneNumberInE164)
        //        self.verification = verification
        //        // retain the verification instance
        //        verification.initiateWithCompletionHandler({(success: Bool, error: NSError?) -> Void in
        //            if success {
        //                // Show UI for entering the code which will be received via SMS
        //                // Show UI for entering the code which will be received via SMS
        //            }
        //        })
        
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
