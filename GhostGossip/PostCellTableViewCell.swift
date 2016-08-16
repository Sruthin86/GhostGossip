//
//  PostCellTableViewCell.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/15/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit

class PostCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var FeedView: UIView!
    @IBOutlet weak var reactButton: UIButton!
    @IBOutlet weak var reactionsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ReactionsContent: UIView!
    @IBOutlet weak var ReactionsView: UIView!
    
    var cellSelected: Bool = false
    var width:CGFloat = 0.4

    @IBOutlet weak var reaction1: UIButton!
    
    @IBOutlet weak var reaction2: UIButton!
    
    @IBOutlet weak var reaction3: UIButton!
    
    @IBOutlet weak var reaction4: UIButton!
    
    @IBOutlet weak var reaction5: UIButton!
    
    @IBOutlet weak var reaction6: UIButton!
    
    
    //@IBOutlet weak var reaction1: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let verylightGrey : Color = Color.verylightGrey
        let customization: UICostomization = UICostomization (color: verylightGrey.getColor(), width:width)
        customization.addBackground(self)
        customization.addBorder(ReactionsView)
        customization.addBorder(FeedView)
        super.awakeFromNib()
        reactionsViewHeight.constant = 0
        self.ReactionsContent.hidden = true
        self.ReactionsView.hidden = true
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func openReactionsView(){
        
        reactionsViewHeight.constant = 76
        self.ReactionsContent.hidden = false
        self.ReactionsView.hidden = false
        
    }
    func closeReactionsView(){
        reactionsViewHeight.constant = 0
        self.ReactionsContent.hidden = true
        self.ReactionsView.hidden = true
        
    }
    
    @IBAction func ReactionButton(sender: AnyObject) {
        animateButton(self.reaction1)
       
        
        
    }
    
    
    @IBAction func Reaction2Button(sender: AnyObject) {
        animateButton(self.reaction2)
        
        
        
    }
    
    @IBAction func Reaction3Button(sender: AnyObject) {
        animateButton(self.reaction3)
        
        
        
    }
    
    
    @IBAction func Reaction4Button(sender: AnyObject) {
        animateButton(self.reaction4)
        
        
        
    }
    
    
    @IBAction func Reaction5Button(sender: AnyObject) {
        animateButton(self.reaction5)
        
        
        
    }
    
    @IBAction func Reaction6Button(sender: AnyObject) {
        animateButton(self.reaction6)
        
        
        
    }
    
    func animateButton(animationObject: UIButton) {
        UIView.animateWithDuration(0.3, delay:0.1, options:[], animations: {
            animationObject.transform = CGAffineTransformMakeScale(2, 2)
            }, completion: {_ in
                
                UIView.animateWithDuration(0.3, delay:0.1, options:[], animations: {
                    animationObject.transform = CGAffineTransformMakeScale(0.5, 0.5)
                        animationObject.alpha = 0.5
                    }, completion: {_ in
                        UIView.animateWithDuration(0.3, delay:0.1, options:[], animations: {
                            animationObject.transform = CGAffineTransformMakeScale(1, 1)
                                animationObject.alpha = 1
                            }, completion: {_ in
                                
                        })
                })
        })
    }

}
