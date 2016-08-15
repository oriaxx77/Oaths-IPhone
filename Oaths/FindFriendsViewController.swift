//
//  FindFriendsViewController.swift
//  Oaths
//
//  Created by Bagyura Istvan on 10/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import UIKit
import CoreData
import Alamofire




class FindFriendsTableViewController: UITableViewController {
    
    var people = [Person]()
    
    // MARK: Event Handlers
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onSave(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UITableViewController
    override func viewWillAppear(animated: Bool) {
        Alamofire.request(.GET,"http://127.0.0.1:8080/person")
            .responseJSON{ (response) -> Void in
                
                guard response.result.isSuccess else {
                    print("Error while fetching people from server: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject],
                rows = value["people"] as? [[String:AnyObject]]else {
                    print("Malformed people data received from server: \(response.result.value)")
                    return
                }
                
                
                self.people = [Person]()
                for personDict in rows {
                    self.people.append( Person(json: personDict))
                }
                
                self.tableView.reloadData();
                
        } ;
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FindFriendsTableViewCell") as? FindFriendsTableViewCell
        let person = people[indexPath.row]
        cell?.nameLabel.text = "\(person.firstName) \(person.surName) (\(person.email))"
        return cell!;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath( indexPath ) {
            if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
    }
    
    // MARK: Actions
    
    
}
