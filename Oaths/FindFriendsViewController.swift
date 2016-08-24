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
import Toast_Swift




class FindFriendsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // MARK: Services and Components
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let findFriendService = FindFriendsService()

    let friendRepository = FriendRepository()
    
    // MARK: State
    
    var people = [Person]()
    
    
    
    
    
    // MARK: Event Handlers
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    // MARK: UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController){
        loadPeopleForSearchText(searchController.searchBar.text!)
    }
    
    
    
    // MARK: UITableViewController
    override func viewDidLoad() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false;
        
    }
    
    
    func loadPeopleForSearchText(searchText: String) {
        findFriendService.loadPeople(filter: searchText, completionHandler: {(people) -> Void in
                self.people = people
                self.tableView.reloadData()
            })
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
        cell?.nameLabel.text = "\(person.firstName) \(person.surName)"
        cell?.emailLabel.text = "(\(person.email))"
        return cell!;
    }
    
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?{
        return [addFriendAction()]
    }
    
    func addFriendAction() -> UITableViewRowAction {
        let addFriendAction = UITableViewRowAction(style: .Default, title: "Add", handler: {action, indexPath in
            do {
                try self.friendRepository.create( fromPerson: self.people[indexPath.row])
                self.people.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath],  withRowAnimation: .Automatic)
                self.showToast( "Friend added" )
            } catch let error as NSError {
                self.showErrorDialog( "Error while adding new friend \(error), details:\(error.userInfo)" )
            }
        })
        return addFriendAction
    }
    
    
}
