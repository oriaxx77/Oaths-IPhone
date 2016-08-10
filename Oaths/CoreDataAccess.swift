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
    func doInDb<R>( action:((managedContext: NSManagedObjectContext) throws -> R)) throws -> R{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        return try action( managedContext: managedContext)
    }
    
    func save() throws {
        try doInDb( {(ctx) -> Void in
            try ctx.save()
        })
    }
    
    func delete( object: NSManagedObject ) throws {
        try doInDb({(ctx) -> Void in
            ctx.deleteObject(object)
            try ctx.save()
        })
    }
}
