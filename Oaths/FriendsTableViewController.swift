//
//  FriendsTableViewController.swift
//  Oaths
//
//  Created by Bagyura Istvan on 06/07/16.
//  Copyright © 2016 p92. All rights reserved.
//

import UIKit
import CoreData

class FriendsTableViewController: UITableViewController {
    
    var friends: [(String)] = ["Garfield", "Michael Jackson"]
    
    // MARK: UITableViewController
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendsTableViewCell") as? FriendsTableViewCell
        cell?.nameLabel.text = friends[indexPath.row]
        return cell!;
    }
}
