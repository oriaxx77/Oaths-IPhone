//
//  FindFriendService.swift
//  Oaths
//
//  Created by Bagyura Istvan on 17/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import Alamofire


class FindFriendsService{
    
    let friendRepository = FriendRepository();
    
    func loadPeople( filter filter: String,
                 completionHandler: ([Person]) -> Void ) {
    
    
        Alamofire.request(.GET, K.EndpointUrls.PersonUrl ,parameters: ["filter": filter])
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
            
            
                let friendEmails: [String]
                do {
                    friendEmails = try self.friendRepository.getAll().map( { $0.email! })
                } catch let error as NSError {
                    print("Couldn't load friends \(error), details:\(error.userInfo)")
                    return
                }
            
            
                var people = [Person]()
                for personDict in rows {
                    let person = Person(json: personDict)
                    if friendEmails.indexOf(person.email) == nil{
                        people.append( person)
                    }
                }
            
                completionHandler( people )
            
        } ;
    
    }
}