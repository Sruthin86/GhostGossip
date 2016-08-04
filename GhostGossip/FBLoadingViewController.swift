//
//  FBLoadingViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/2/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FBLoadingViewController: UIViewController {
    
    var overlayView = UIView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var spinner:loadingAnimation = loadingAnimation(overlayView: overlayView, senderView: self.view)
        spinner.showOverlay(0)
        let myTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("LoginWithFacebook:"), userInfo: nil, repeats: false)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func LoginWithFacebook(timer : NSTimer) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        //fbLoginManager.loginBehavior = FBSDKLoginBehavior.Browser
        
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"], handler: { (result, error) -> Void in
            
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                
                if(fbloginresult.isCancelled) {
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                    FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                        // ...
                        if let user = FIRAuth.auth()?.currentUser {
                            let databaseRef = FIRDatabase.database().reference()
                            let uModel =  UserModel(name : user.displayName, userName: "", email: user.email, photoUrl:user.photoURL?.absoluteString , phoneNumber:""  )
                            let uid = user.uid
                            let postUserData : [String : AnyObject] = ["displayName": uModel.name!,"photo": uModel.photoUrl!, "email":uModel.email!, "userName":user.uid ]
                            databaseRef.child("Users").child(uid).setValue(postUserData)
                            dispatch_async(dispatch_get_main_queue(), {
                                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewControllerWithIdentifier("userNameandPh") as! UserNameAndPhoneNoViewController
                                self.presentViewController(vc, animated:true, completion:nil)
                                
                            })
                            
                        }
                        
                    }
                }
            }
        })

    }

    


}
