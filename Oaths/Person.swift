//
//  Person.swift
//  Oaths
//
//  Created by Bagyura Istvan on 15/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation

class Person {
    let email: String
    let firstName: String
    let surName: String
    
    init( email: String, firstName: String, surName: String ){
        self.email = email
        self.firstName = firstName
        self.surName = surName
    }
    
    init( json: [String:AnyObject] ){
        self.email = json["email"] as! String
        self.firstName = json["firstName"] as! String
        self.surName = json["surName"] as! String
    }
}
