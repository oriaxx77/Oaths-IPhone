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
        print( "json: \(json)" )
        self.email = "some email"
        self.firstName = "some firstName"
        self.surName = "some surName"
    }
}
