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
    
    var strangers = [Person]()

    
    
    
    
    // MARK: Event Handlers
    
    @IBAction func onCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // MARK: UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController){
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
    
    
    func loadPeopleForSearchText(_ searchText: String) {
        findFriendService.getStrangers(filter: searchText, completionHandler: {(strangers) -> Void in
                self.strangers = strangers
                print("self.strangers.count: \(self.strangers.count)")
                self.tableView.reloadData()
            })
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strangers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFriendsTableViewCell") as? FindFriendsTableViewCell
        let person = strangers[(indexPath as NSIndexPath).row]
        cell?.oathLabel.text = "\(person.oath)"
        cell?.nameLabel.text = "\(person.name)"
        cell?.emailLabel.text = "\(person.email)"
        return cell!;
    }
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        return [addFriendAction()]
    }
    
    func addFriendAction() -> UITableViewRowAction {
        let addFriendAction = UITableViewRowAction(style: .default, title: "Add", handler: {action, indexPath in
            self.tryExec {
                try self.friendRepository.create( fromPerson: self.strangers[(indexPath as NSIndexPath).row])
                self.strangers.remove(at: (indexPath as NSIndexPath).row)
                self.tableView.deleteRows(at: [indexPath],  with: .automatic)
                self.showToast( "Friend added" )
            }
        })
        return addFriendAction
    }
    
    
}
