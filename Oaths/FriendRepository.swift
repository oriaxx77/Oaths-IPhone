//
//  FriendRepository.swift
//  Oaths
//
//  Created by Bagyura Istvan on 15/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import CoreData

class FriendRepository: GenericRepository<Friend>{
    
 
    func create( fromPerson person:Person ) throws -> Friend? {
        let uniquePredicate = NSPredicate( format: "email == %@", person.email )
        return try super.create( uniquePredicate, setProperties: { (friend) -> Void in
            friend.email = person.email
            friend.firstName = person.firstName
            friend.surName = person.surName
        })
    }
    
}
