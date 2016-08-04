//
//  Color.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/3/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import Foundation
import UIKit


enum Color {
    case green
    
    func getColor() -> UIColor {
        
        switch self {
            
        case .green:
            let myColor : UIColor = UIColor( red: 0.00, green: 0.65, blue:0.47, alpha: 1.0 )
            return myColor
            
        }
        
        
    }
}
