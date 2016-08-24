//
//  GenericRepo.swift
//  Oaths
//
//  Created by Bagyura Istvan on 10/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GenericRepository<T:NSManagedObject>: NSObject{
    
    let coreDataAccess: CoreDataAccess
    let entityName: String
    
    override init(){
        self.coreDataAccess = CoreDataAccess();
        self.entityName = String(T.self)
    }
    
    func getAll() throws -> [T]{
        return try coreDataAccess.doInDb({(ctx) throws -> [T] in
            let fetchRequest = NSFetchRequest(entityName: self.entityName)
            let results = try ctx.executeFetchRequest(fetchRequest)
            return results as! [T]
        })
    }
    
    func doInDb<R>( action:((managedContext: NSManagedObjectContext) throws -> R)) throws -> R{
        return try coreDataAccess.doInDb( action )
    }
    
    func save() throws {
        try coreDataAccess.save()
    }
    
    func delete( entity:T) throws {
        try coreDataAccess.delete( entity )
    }
    
    func create( uniquePredicate: NSPredicate, setProperties:((t:T) -> Void)) throws -> T? {
        
        return try coreDataAccess.doInDb({(ctx) throws -> T? in
            
            // Create Oath entity
            let entity = NSEntityDescription.entityForName( self.entityName, inManagedObjectContext: ctx)
            
            
            // Check if entity exist
            let fetchRequest = NSFetchRequest()
            fetchRequest.entity = entity;
            fetchRequest.predicate = uniquePredicate
            let results = try ctx.executeFetchRequest(fetchRequest)
            if ( !(results as! [NSManagedObject]).isEmpty ) {
                return T?()
            }
            
            // Create if it does not exist
            let newObject = T(entity: entity!,insertIntoManagedObjectContext: ctx)
            setProperties( t: newObject );
            try ctx.save()
            return newObject;
        })
    }
    
}

