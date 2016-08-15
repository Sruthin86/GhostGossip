//
//  PostViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/14/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit
import Foundation

class PostViewController: UIViewController {
    
    @IBOutlet weak var PostText: UITextField!
    
    @IBOutlet weak var PostAsMeView: UIView!
    
    @IBOutlet weak var PostAsGhostView: UIView!
    
    @IBOutlet weak var PostAndGuessView: UIView!
    
    @IBOutlet weak var CancelView: UIView!
    
    @IBOutlet weak var TopViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ButtonViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var PostButtonsView: UIView!
    
    var userIsEditing:Bool = false
    
     var width:CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lightGrey:Color = Color.lightGrey
        let customization :UICostomization = UICostomization(color:lightGrey.getColor(), width:width)
        customization.addBorder(self.PostAsMeView)
        customization.addBorder(self.PostAsGhostView)
        customization.addBorder(self.PostAndGuessView)
        customization.addBorder(self.CancelView)
        PostText.addTarget(self, action: #selector(PostViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.AllEvents)
        self.PostButtonsView.hidden = true
        self.ButtonViewHeight.constant = 0
        self.TopViewHeight.constant = 65
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(textField: UITextField) {
        if(!userIsEditing){
            userIsEditing = !userIsEditing
            self.PostButtonsView.hidden = false
            self.ButtonViewHeight.constant = 40
            self.TopViewHeight.constant = 105
        }
        
    }
    
    @IBAction func CancelEditing(sender: AnyObject) {
        
       textFieldShouldReturn(self.PostText)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        self.PostText.resignFirstResponder()
        self.PostText.text = ""
        self.PostButtonsView.hidden = true
        self.ButtonViewHeight.constant = 0
        self.TopViewHeight.constant = 65
        userIsEditing = !userIsEditing
        return true;
    }
    
}
