//
//  PostViewController.swift
//  GhostGossip
//
//  Created by Sruthin Gaddam on 8/14/16.
//  Copyright © 2016 Sruthin Gaddam. All rights reserved.
//

import UIKit
import Foundation

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
    
    
    var userIsEditing:Bool = false
    
    var width:CGFloat = 1
    
    let refreshControl :UIRefreshControl = UIRefreshControl()

    
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
        refreshControl.addTarget(self, action: Selector("uiRefreshActionControl"), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let postFeedCell = tableView.dequeueReusableCellWithIdentifier("PostViewCell", forIndexPath: indexPath) as! PostCellTableViewCell
        postFeedCell.ReactionsContent.hidden = true
        postFeedCell.reactButton.tag = indexPath.row
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
    
    
    
}
