//
//  Oath.swift
//  Oaths
//
//  Created by Bagyura Istvan on 06/07/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import CoreData


class Oath: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
        
    func incrementTemptationFailed(){
        self.temptationFailed = NSNumber( int: self.temptationFailed!.integerValue + 1 )
    }
    
    func incrementTemptationResisted(){
        self.temptationResisted = NSNumber( int: self.temptationResisted!.integerValue + 1 )
    }

}
