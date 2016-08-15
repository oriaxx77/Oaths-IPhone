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
        do {
            friends = try self.friendsRepository.getAll()
        } catch let error as NSError {
            self.showErrorDialog( "Error while loading friends \(error), details: \(error.userInfo)")
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
        cell?.nameLabel.text = "\(friend.firstName) \(friend.surName) (\(friend.email))"
        return cell!;
    }
}
