//
//  FindFriendService.swift
//  Oaths
//
//  Created by Bagyura Istvan on 17/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import Alamofire


class FindFriendsService
{
    
    let friendRepository = FriendRepository();
    
    
    func getStrangers( filter: String,
                       completionHandler: @escaping ([Person]) -> Void ) {
    
        
        
        Alamofire.request( K.EndpointUrls.PublicOaths, method: .get, parameters: ["filter": filter], encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("Error while fetching people from server: \(response.result.error)")
                    return
                }

                guard let peopleJson = response.result.value as? [[String: AnyObject]] else {
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
                for personJson in peopleJson {
                    let person = Person(json: personJson)
                    if !friendEmails.contains(person.email) {
                        people.append( person)
                    }
                }
                
                completionHandler( people )

        }
        
    }
}
