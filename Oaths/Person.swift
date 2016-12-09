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
    let name: String
    let oath: String
    
    init( email: String, name: String, oath: String ){
        self.email = email
        self.name = name
        self.oath = oath
    }
    
    init( json: [String:AnyObject] ){
        self.oath = json["oath"] as! String
        let oathTaker = json["oathTaker"] as! [String: AnyObject]
        self.name = oathTaker["name"] as! String
        self.email = oathTaker["email"] as! String
        
    }
}
