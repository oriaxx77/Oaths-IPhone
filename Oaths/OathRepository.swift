//
//  OathRepo.swift
//  Oaths
//
//  Created by Bagyura Istvan on 06/07/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class OathRepository: GenericRepository<Oath>{
    
    func createIfNotExist(_ oathString: String) throws -> Oath? {
        let uniquePredicate = NSPredicate( format: "oath == %@", oathString );
        return try super.createIfNotExist(uniquePredicate, setProperties: {(oath) -> Void in
            oath.oath = oathString
            oath.temptationFailed = 0
            oath.temptationFailed = 0
            oath.creationDate = Date()
        })
    }
    
}
