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
    
    @IBAction func addNewFriend(_ sender: UIBarButtonItem) {
    }
    
    // MARK: UITableViewController
    
    override func viewWillAppear(_ animated: Bool) {
        tryExec {
            self.friends = try self.friendsRepository.getAll()
            self.tableView.reloadData()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as? FriendsTableViewCell
        let friend = friends[(indexPath as NSIndexPath).row]
        cell?.nameLabel.text = "\(friend.firstName!) \(friend.surName!)"
        cell?.emailLabel.text = "\(friend.email!)"
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        return [deleteAction()]
    }
    
    func deleteAction() -> UITableViewRowAction {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {action, indexPath in
            self.tryExec {
                try self.friendsRepository.delete( self.friends[(indexPath as NSIndexPath).row] )
                self.friends.remove( at: (indexPath as NSIndexPath).row )
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        })
        return deleteAction
    }
    
    
}
