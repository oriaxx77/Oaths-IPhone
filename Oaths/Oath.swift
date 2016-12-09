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
        self.temptationFailed = NSNumber(value: self.temptationFailed!.intValue + 1 as Int32)
    }
    
    func incrementTemptationResisted(){
        self.temptationResisted = NSNumber(value: self.temptationResisted!.intValue + 1 as Int32)
    }

}
