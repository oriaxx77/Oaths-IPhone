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

class OathRepo: NSObject{
    
    func doInDb<R>( action:((managedContext: NSManagedObjectContext) throws -> R)) throws -> R{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        return try action( managedContext: managedContext)
    }
    
    func getAll() throws -> [Oath]{
        return try self.doInDb({(ctx) throws -> [Oath] in
            let fetchRequest = NSFetchRequest(entityName: "Oath")
            let results = try ctx.executeFetchRequest(fetchRequest)
            return results as! [Oath]
        })
    }
    
    func createOath(oathString: String) throws -> Oath? {
        
        return try self.doInDb({(ctx) throws -> Oath? in
            
            // Creae Oath entity
            let entity = NSEntityDescription.entityForName("Oath", inManagedObjectContext: ctx)
            
            
            // Check if entity exist
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = entity;
            fetchRequest.predicate = NSPredicate( format: "oath == %@", oathString )
            let results = try ctx.executeFetchRequest(fetchRequest)
            if ( !(results as! [NSManagedObject]).isEmpty ) {
                return Oath?()
            }
            
            
            
            // Create if it does not exist
            let oath = Oath(entity: entity!,insertIntoManagedObjectContext: ctx)
            oath.oath = oathString
            oath.temptationFailed = 0
            oath.temptationFailed = 0
            oath.creationDate = NSDate()
            try ctx.save()
            return oath
        })
    }
    
}
