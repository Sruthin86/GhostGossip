//
//  PostViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/14/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class PostViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var PostText: UITextField!
    
    @IBOutlet weak var PostAsMeView: UIView!
    
    @IBOutlet weak var PostAsGhostView: UIView!
    
    @IBOutlet weak var PostAndGuessView: UIView!
    
    @IBOutlet weak var CancelView: UIView!
    
    @IBOutlet weak var TopViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ButtonViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var PostButtonsView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let KclosedHeight : CGFloat = 144
    let KopenHeight :CGFloat = 220
    
    var selectedInxexPath: NSIndexPath?
    var selectedInxexPathsArray :[NSIndexPath] = []
    
    @IBOutlet weak var postLabel: UILabel!
    
    
    
    var userIsEditing:Bool = false
    
    var width:CGFloat = 1
    
    let refreshControl :UIRefreshControl = UIRefreshControl()
    
    let uid = NSUserDefaults.standardUserDefaults().objectForKey(fireBaseUid)
    
    let ref = FIRDatabase.database().reference()
    
    var postsArray = [String: AnyObject]()
    
    var postKeys = [String]()
    
    let helperClass : HelperFunctions = HelperFunctions()
    
    
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
        refreshControl.addTarget(self, action: #selector(PostViewController.uiRefreshActionControl), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        getPosts()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func uiRefreshActionControl() {
        self.animateTable()
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
        
        helperClass.returnFromTextField(self.PostText, PostButtonsView: PostButtonsView, ButtonViewHeight: ButtonViewHeight, TopViewHeight: TopViewHeight)
        userIsEditing = !userIsEditing
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.postsArray.keys.count == 0){
            let textColor: Color = Color.grey
            let noDataAvailableLabel: UILabel = UILabel(frame: CGRectMake(0, 300, self.tableView.frame.width, self.tableView.frame.height) )
            noDataAvailableLabel.text =  "Sorry , there is No Activity yet!"
            noDataAvailableLabel.textAlignment = .Center
            noDataAvailableLabel.textColor =  textColor.getColor()
            noDataAvailableLabel.font = UIFont(name: "Avenir-Next", size:14.0)
            self.tableView.backgroundView = noDataAvailableLabel
        }
        
        
        
        return self.postsArray.keys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let postFeedCell = tableView.dequeueReusableCellWithIdentifier("PostViewCell", forIndexPath: indexPath) as! PostCellTableViewCell
        postFeedCell.ReactionsContent.hidden = true
        postFeedCell.reactButton.tag = indexPath.row
        var postFeed :[String: AnyObject] = self.postsArray[self.postKeys[indexPath.row]]! as! [String : AnyObject]
        postFeedCell.postLabel.text  = postFeed["post"] as! String
        postFeedCell.reactButton.addTarget(self, action: #selector(self.reactionsActions), forControlEvents: .TouchUpInside)
        guard self.selectedInxexPath != nil else {
            
            return postFeedCell
        }
        if (self.selectedInxexPath! == indexPath){
            postFeedCell.ReactionsContent.hidden = false
        }
        return postFeedCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let selIndex = selectedInxexPath?.row {
            if(selIndex == indexPath.row){
                return KopenHeight
            }
            else {
                return KclosedHeight
            }
        }
        else {
            return KclosedHeight
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    func reactionsActions(sender: AnyObject) -> Void {
        let selectedCellIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        selectedInxexPathsArray.removeAll()
        if (selectedInxexPath != nil) {
            let previousSelectedPath :NSIndexPath = selectedInxexPath!
            print(previousSelectedPath.row)
            selectedInxexPathsArray.append(previousSelectedPath)
        }
        
        
        
        
        guard ((selectedInxexPath) != nil)  else {
            
            selectedInxexPath = selectedCellIndexPath
            selectedInxexPathsArray.append(selectedInxexPath!)
            self.tableView.reloadRowsAtIndexPaths(selectedInxexPathsArray, withRowAnimation: UITableViewRowAnimation.Fade)
            let cell = tableView.cellForRowAtIndexPath(selectedCellIndexPath) as! PostCellTableViewCell
            cell.openReactionsView()
            return
            
        }
        
        if selectedInxexPath!.row != selectedCellIndexPath.row{
            selectedInxexPath = selectedCellIndexPath
            selectedInxexPathsArray.append(selectedInxexPath!)
            self.tableView.reloadRowsAtIndexPaths(selectedInxexPathsArray, withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.beginUpdates()
            let cell = tableView.cellForRowAtIndexPath(selectedCellIndexPath) as! PostCellTableViewCell
            cell.openReactionsView()
            self.tableView.endUpdates()
            
        }
        else if (selectedInxexPath!.row == selectedCellIndexPath.row){
            selectedInxexPathsArray.append(selectedInxexPath!)
            self.selectedInxexPath = nil
            let cell = tableView.cellForRowAtIndexPath(selectedCellIndexPath) as! PostCellTableViewCell
            cell.closeReactionsView()
            self.tableView.beginUpdates()
            self.tableView.reloadRowsAtIndexPaths(selectedInxexPathsArray, withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.endUpdates()
            selectedInxexPathsArray.removeAll()
            
        }
        
        
        
    }
    
    
    func animateTable() {
        self.tableView.reloadData()
        let cells = self.tableView.visibleCells
        
        let tableHeight:CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell :UITableViewCell = i
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
            
        }
        
        var index = 0
        for a in cells {
            let cell :UITableViewCell = a
            UIView.animateWithDuration(1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 1, initialSpringVelocity: 0.5  ,options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion : nil)
        }
        self.refreshControl.endRefreshing()
    }
    
    
    func getPosts(){
        
        ref.child("Posts").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            
            guard !snapshot.exists() else {
                var pModel = postModel(posts: snapshot)
                self.postsArray = pModel.returnPostsForArray() as! [String : AnyObject]
                self.postKeys = pModel.returnPostKeys()
                self.tableView.reloadData()
                return 
            }
            
        })
        
        
        
    }
    
    
    func saveNewPost(post:String, uid: String) {
        
        
        ref.child("Users").child(uid).observeSingleEventOfType(FIRDataEventType.Value, withBlock :{ (snapshot) in
            let userData =  snapshot.value as! [String:AnyObject]
            let displayName = userData["displayName"]
            let reactionsData: [String:Int] = ["Reaction1": 0, "Reaction2": 0, "Reaction3": 0, "Reaction4": 0, "Reaction5": 0, "Reaction6": 0]
            let postMetrics: [String:Int] = ["flag":0, "correctGuess":0, "wrongGuess":0]
            let postData : [String: AnyObject] = ["post":post , "useruid": uid, "displayName":displayName!, "reactionsData":reactionsData, "postMetrics":postMetrics]
            
            let postDataRef = self.ref.child("Posts").childByAutoId()
            postDataRef.setValue(postData)
            let postDataId = postDataRef.key
            
            self.ref.child("Users").child(uid).child("posts").setValue(["postId":postDataId])
            // ...
        })
        
        
        
        
        
    }
    
    @IBAction func postAsMe(sender: AnyObject) {
        
        if( !((self.PostText.text?.isEmpty)!) || (self.PostText.text?.characters.count > 200) ){
            self.saveNewPost((self.PostText?.text)!, uid:self.uid as! String)
            helperClass.returnFromTextField(self.PostText, PostButtonsView: PostButtonsView, ButtonViewHeight: ButtonViewHeight, TopViewHeight: TopViewHeight)
            userIsEditing = !userIsEditing
            
        }
        
        
    }
    
    
    
}
