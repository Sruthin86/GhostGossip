//
//  UICustomization.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/14/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//




import UIKit
import Foundation

struct UICostomization {
    var color:UIColor
    var width:CGFloat = 0.4
    
    init(color:UIColor){
        self.color = color
    }
    
    func addBorder(object:AnyObject){
        object.layer.borderWidth = self.width
        object.layer.borderColor = self.color.CGColor
    }
    
    func addBackground(object:AnyObject){
        object.layer.backgroundColor = self.color.CGColor
    }
}
