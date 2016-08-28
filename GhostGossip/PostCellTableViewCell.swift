//
//  PostCellTableViewCell.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/15/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

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
    
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    let ref = FIRDatabase.database().reference()
    
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
                    animationObject.transform = CGAffineTransformRotate(animationObject.transform, CGFloat(M_PI))
                        animationObject.alpha = 0.5
                    }, completion: {_ in
                        UIView.animateWithDuration(0.4, delay:0.0, options:[], animations: {
                            animationObject.transform = CGAffineTransformMakeScale(1, 1)
                                animationObject.alpha = 1
                            }, completion: {_ in
                                
                        })
                })
        })
    }
    
    
    func assignImage(postType:Int, postUid: String  ) {
        
        switch  postType {
            
        case 1:
            self.getImage(postUid)
        case 2:
            self.cellImage.image = UIImage(named:  "Logo")
        default:
            self.cellImage.image = UIImage(named:  "CrystalBall")
        }
        
    }
    
    func getImage(postUid: String) {
      ref.child("Users").child(postUid).observeSingleEventOfType(FIRDataEventType.Value, withBlock:{ (snapshot) in
        let userDetails = snapshot.value as! [String: AnyObject]
        let fileUrl = NSURL(string: userDetails["highResPhoto"] as! String)
        let profilePicUrl = NSData(contentsOfURL:  fileUrl!)
        self.cellImage.image = UIImage(data: profilePicUrl!)
        let green : Color = Color.green
        let customization: UICostomization  = UICostomization(color:green.getColor(), width: 2 )
        customization.addBorder(self.cellImage)
        self.cellImage.layer.cornerRadius  = self.cellImage.frame.width/2
        self.cellImage.clipsToBounds = true;
        

      })
        
    }
    
    
    func configureImage(postId: String)  {
        var userUid : String?
        var postTypeId : Int?
        self.ref.child("Posts").child(postId).observeSingleEventOfType(FIRDataEventType.Value,  withBlock: { (snapshot)in
            let pData = snapshot.value as! [String : AnyObject]
            userUid  = pData["useruid"] as? String
            postTypeId = pData["postType"] as? Int
            self.assignImage(postTypeId!, postUid: userUid!)
            
        })
        
        
    }
    

}
