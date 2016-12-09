//
//  CoreDataAccess.swift
//  Oaths
//
//  Created by Bagyura Istvan on 10/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataAccess {
    
    func doInDb<R>(
        
        _ action:   ((_ managedContext: NSManagedObjectContext) throws -> R)
        
        ) throws -> R
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        return try action( managedContext)
    }
    
    func save() throws {
        try doInDb( {(ctx) -> Void in
            try ctx.save()
        })
    }
    
    func delete( _ object: NSManagedObject ) throws {
        try doInDb({(ctx) -> Void in
            ctx.delete(object)
            try ctx.save()
        })
    }
}
