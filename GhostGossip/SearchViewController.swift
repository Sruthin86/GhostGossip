//
//  SearchViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 9/10/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchUserbtn: UIButton!
    
    @IBOutlet weak var requestsBtn: UIButton!
    
    @IBOutlet weak var suggestionsBtn: UIButton!
    
    var width:CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lightgrey :Color = Color.lightGrey
        let customization : UICostomization = UICostomization(color: lightgrey.getColor(), width: width )
        customization.addBorder(self.searchUserbtn)
        customization.addBorder(self.requestsBtn)
        customization.addBorder(self.suggestionsBtn)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
