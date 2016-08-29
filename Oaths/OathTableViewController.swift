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
    
    var oathRepo = OathRepository()
    
    // MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"Your Oaths\""
        tableView.allowsMultipleSelection = false
    }

    
    override func viewWillAppear(animated: Bool) {
        tryExec {
            try self.oaths = self.oathRepo.getAll();
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
        
        tryExec{ let oathOpt =  try self.oathRepo.create(oathString)
              if let oath =  oathOpt {
                self.oaths.append(oath)
                self.tableView.reloadData()}
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
        return [deleteAction(),resistTemptationAction(),failTemptationAction()]
    }
    
    
    
    func resistTemptationAction() -> UITableViewRowAction {
        let resistTempatationAction = UITableViewRowAction(style: .Default, title: "Resisted", handler: {action,idxPath in
            self.tryExec {
                self.oaths[idxPath.row].incrementTemptationResisted();
                try self.oathRepo.save()
                self.tableView.reloadRowsAtIndexPaths([idxPath], withRowAnimation: .Automatic)
            }
        })
        resistTempatationAction.backgroundColor = UIColor.greenColor()
        return resistTempatationAction
    }
    
    
    func failTemptationAction() -> UITableViewRowAction {
        
        let failTemptationAction = UITableViewRowAction(style: .Default, title: "Failed", handler: {action,idxPath in
            self.tryExec{
                self.oaths[idxPath.row].incrementTemptationFailed();
                try self.oathRepo.save()
                self.tableView.reloadRowsAtIndexPaths([idxPath], withRowAnimation: .Automatic)
            }
        })
        failTemptationAction.backgroundColor = UIColor.orangeColor()
        return failTemptationAction
    }
    
    
    func deleteAction() -> UITableViewRowAction {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: {action, indexPath in
            self.tryExec {
                try self.oathRepo.delete( self.oaths[indexPath.row] )
                self.oaths.removeAtIndex( indexPath.row )
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            
        })
        return deleteAction
    }
    
}

