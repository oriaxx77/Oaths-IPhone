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

    
    override func viewWillAppear(_ animated: Bool) {
        tryExec {
            try self.oaths = self.oathRepo.getAll();
        }
    }

    // MARK: actions
    @IBAction func createNewOath(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Oath", message: "Add a new oath", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler:{ (action: UIAlertAction) -> Void in
                                        let textField = alert.textFields!.first
                                        self.createOath(textField!.text!)
                                        
        })
        alert.addAction(saveAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(action: UIAlertAction)-> Void in})
        alert.addAction(cancelAction)
        alert.addTextField{
            (textField:UITextField) -> Void in
        }
        present(alert, animated: false, completion: nil)
        
    }
    
    
    func createOath(_ oathString: String) -> Void {
        
        tryExec{ let oathOpt =  try self.oathRepo.createIfNotExist(oathString)
              if let oath =  oathOpt {
                self.oaths.append(oath)
                self.tableView.reloadData()}
        }
    }
    
    
    
    
    // MARK: UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oaths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OathTableViewCell") as? OathTableViewCell
        let oath = oaths[(indexPath as NSIndexPath).row]
        cell!.oathLabel!.text = oath.oath
        cell!.temptationFailedLabel!.text = String(describing: oath.temptationFailed!)
        cell!.temptationResistedLabel!.text = String(describing: oath.temptationResisted!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let creationDateString = dateFormatter.string(from: oath.creationDate! as Date)
        cell!.creationDateLabel!.text = creationDateString
        return cell!
    }
    

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [deleteAction(),resistTemptationAction(),failTemptationAction()]
    }
    
    
    
    func resistTemptationAction() -> UITableViewRowAction {
        let resistTempatationAction = UITableViewRowAction(style: .default, title: "Resisted", handler: {action,idxPath in
            self.tryExec {
                self.oaths[(idxPath as NSIndexPath).row].incrementTemptationResisted();
                try self.oathRepo.save()
                self.tableView.reloadRows(at: [idxPath], with: .automatic)
            }
        })
        resistTempatationAction.backgroundColor = UIColor.green
        return resistTempatationAction
    }
    
    
    func failTemptationAction() -> UITableViewRowAction {
        
        let failTemptationAction = UITableViewRowAction(style: .default, title: "Failed", handler: {action,idxPath in
            self.tryExec{
                self.oaths[(idxPath as NSIndexPath).row].incrementTemptationFailed();
                try self.oathRepo.save()
                self.tableView.reloadRows(at: [idxPath], with: .automatic)
            }
        })
        failTemptationAction.backgroundColor = UIColor.orange
        return failTemptationAction
    }
    
    
    func deleteAction() -> UITableViewRowAction {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {action, indexPath in
            self.tryExec {
                try self.oathRepo.delete( self.oaths[(indexPath as NSIndexPath).row] )
                self.oaths.remove( at: (indexPath as NSIndexPath).row )
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        })
        return deleteAction
    }
    
}

