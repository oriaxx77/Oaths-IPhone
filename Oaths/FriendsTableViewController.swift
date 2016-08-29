//
//  FriendsTableViewController.swift
//  Oaths
//
//  Created by Bagyura Istvan on 06/07/16.
//  Copyright © 2016 p92. All rights reserved.
//

import UIKit
import CoreData
import Alamofire




class FriendsTableViewController: UITableViewController {
    
    var friends = [Friend]()
    
    let friendsRepository = FriendRepository()
    
    
    // MARK: Event Handlers
    
    @IBAction func addNewFriend(sender: UIBarButtonItem) {
    }
    
    // MARK: UITableViewController
    
    override func viewWillAppear(animated: Bool) {
        tryExec {
            self.friends = try self.friendsRepository.getAll()
            self.tableView.reloadData()
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendsTableViewCell") as? FriendsTableViewCell
        let friend = friends[indexPath.row]
        cell?.nameLabel.text = "\(friend.firstName!) \(friend.surName!)"
        cell?.emailLabel.text = "\(friend.email!)"
        return cell!;
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?{
        return [deleteAction()]
    }
    
    func deleteAction() -> UITableViewRowAction {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: {action, indexPath in
            self.tryExec {
                try self.friendsRepository.delete( self.friends[indexPath.row] )
                self.friends.removeAtIndex( indexPath.row )
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        })
        return deleteAction
    }
    
    
}
