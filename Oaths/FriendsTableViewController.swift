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
    
    var friends: [(String)] = ["Garfield", "Michael Jackson"]
    
    // MARK: UITableViewController
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {


        Alamofire.request(.GET,"http://127.0.0.1:8080/person")
            .responseJSON{ (response) -> Void in
                
                guard let value = response.result.value as? [String: AnyObject]
                else {
                    print("error")
                    return
                }
                print( "Response: \(value)")
                
        } ;
        
        
        
//        Alamofire.request(
//            .GET,
//            "http://127.0.0.1:8080/person",
//            parameters: ["include_docs": "true"],
//            encoding: .URL)
//            .validate()
//            .responseJSON { (response) -> Void in
//                guard response.result.isSuccess else {
//                    print("Error while fetching remote rooms: \(response.result.error)")
//                    completion(nil)
//                    return
//                }
//                
//                guard let value = response.result.value as? [String: AnyObject],
//                    rows = value["rows"] as? [[String: AnyObject]] else {
//                        print("Malformed data received from fetchAllRooms service")
//                        completion(nil)
//                        return
//                }
//                
//                var rooms = [RemoteRoom]()
//                for roomDict in rows {
//                    rooms.append(RemoteRoom(jsonData: roomDict))
//                }
//                
//                completion(rooms)
//        }
        
//        do {
//            
//        } catch let error as NSError {
//            print( "Error while loading oaths \(error), deails:\(error.userInfo)" )
//        }
        
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
