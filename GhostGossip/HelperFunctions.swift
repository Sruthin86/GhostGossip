//
//  HelperFunctions.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/28/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import Foundation
import UIKit

class HelperFunctions {
    
    func returnFromTextField(textField: UITextField! , PostButtonsView: UIView, ButtonViewHeight: NSLayoutConstraint, TopViewHeight: NSLayoutConstraint  ) //
    {
        
        
        textField.resignFirstResponder()
        textField.text = ""
        PostButtonsView.hidden = true
        ButtonViewHeight.constant = 0
        TopViewHeight.constant = 65
        
        
        
    }
 
    
}