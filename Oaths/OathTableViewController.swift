//
//  ViewController.swift
//  HitList
//
//  Created by Bagyura Istvan on 07/06/16.
//  Copyright © 2016 p92. All rights reserved.
//

import UIKit
import CoreData

class OathTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: controls
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: state
    var oaths = [Oath]()
    
    var oathRepo = OathRepo()
    
    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"Your Oaths\""
        tableView.allowsMultipleSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        do {
            try self.oaths = oathRepo.getAll();
        } catch let error as NSError {
            self.showErrorDialog( "Error while loading oaths \(error), deails:\(error.userInfo)" )
        }
        
    }

    // MARK: actions
    @IBAction func createNewOath(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Oath", message: "Add a new oath", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler:{ (action: UIAlertAction) -> Void in
                                        let textField = alert.textFields!.first
                                        self.createOath(textField!.text!)
                                        
                                        
                                        
        })
        alert.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {(action: UIAlertAction)-> Void in})
        alert.addAction(cancelAction)
        
        alert.addTextFieldWithConfigurationHandler{
            (textField:UITextField) -> Void in
        }
        
        presentViewController(alert, animated: false, completion: nil)
        
    }
    
    
    func createOath(oathString: String) -> Void {
        do {
            let oathOpt =  try oathRepo.createOath(oathString)
            if let oath =  oathOpt {
                oaths.append(oath)
                tableView.reloadData()
            }
        } catch let error as NSError {
            self.showErrorDialog( "Error while loading oaths \(error), deails:\(error.userInfo)" )
        }
    }
    
    
    
    
    // MARK: UITableViewDataSource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return oaths.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OathTableViewCell") as? OathTableViewCell
        let oath = oaths[indexPath.row]
        cell!.oathLabel!.text = oath.oath
        cell!.temptationFailedLabel!.text = String(oath.temptationFailed!)
        cell!.temptationResistedLabel!.text = String(oath.temptationResisted!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let creationDateString = dateFormatter.stringFromDate(oath.creationDate!)
        cell!.creationDateLabel!.text = creationDateString
        return cell!
    }
    

    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: {action,idxPath in
            do {
                try self.oathRepo.doInDb( {(ctx) -> Void in
                    ctx.deleteObject( self.oaths[indexPath.row] )
                    try ctx.save()
                    self.oaths.removeAtIndex( indexPath.row )
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                } )
            } catch let error as NSError {
                self.showErrorDialog( "Error while loading oaths \(error), deails:\(error.userInfo)" )
            }

        })
        
        
        let resistTempatationAction = UITableViewRowAction(style: .Default, title: "Resisted", handler: {action,idxPath in
            do {
                try self.oathRepo.doInDb({ (ctx) -> Void in
                    let oath = self.oaths[idxPath.row]
                    oath.temptationResisted = NSNumber( int: oath.temptationResisted!.integerValue + 1 )
                    try ctx.save()
                    tableView.reloadRowsAtIndexPaths([idxPath], withRowAnimation: .Automatic)
                })
            } catch let error as NSError {
                self.showErrorDialog( "Error while increasing resisting temptation \(error), deails:\(error.userInfo)" )
            }
        })
        resistTempatationAction.backgroundColor = UIColor.greenColor()
 
        let failTemptationAction = UITableViewRowAction(style: .Default, title: "Failed", handler: {action,idxPath in
            do {
                try self.oathRepo.doInDb({ (ctx) -> Void in
                    let oath = self.oaths[idxPath.row]
                    oath.temptationFailed = NSNumber( int: oath.temptationFailed!.integerValue + 1 )
                    try ctx.save()
                    tableView.reloadRowsAtIndexPaths([idxPath], withRowAnimation: .Automatic)
                })
            } catch let error as NSError {
                self.showErrorDialog( "Error while increasing failedTemptation \(error), deails:\(error.userInfo)" )
            }
        })
        failTemptationAction.backgroundColor = UIColor.orangeColor()
        return [deleteAction,resistTempatationAction,failTemptationAction]
    }
    
    func showErrorDialog( message: String ){
        let alert = UIAlertController(title: "Hey", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

