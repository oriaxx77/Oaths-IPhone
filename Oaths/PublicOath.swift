//
//  PublicOath.swift
//  Oaths
//
//  Created by Bagyura Istvan on 2016. 12. 09..
//  Copyright © 2016. p92. All rights reserved.
//

import Foundation

class PublicOath
{
    let oath: string
    
    init( json: [String:AnyObject] ){
        self.email = json["email"] as! String
        self.name = json["name"] as! String
    }
}
