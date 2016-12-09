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

enum GenericRepositoryError: Error {
    case existingEntity
}

class GenericRepository<T:NSManagedObject>: NSObject{
    
    let coreDataAccess: CoreDataAccess
    
    override init(){
        self.coreDataAccess = CoreDataAccess();
    }
    
    func getAll() throws -> [T]{
        return try coreDataAccess.doInDb({(ctx) throws -> [T] in
            let results = try ctx.fetch( T.fetchRequest() )
            return results as! [T]
        })
    }
    
    func doInDb<R>( _ action:((_ managedContext: NSManagedObjectContext) throws -> R)) throws -> R{
        return try coreDataAccess.doInDb( action )
    }
    
    func save() throws {
        try coreDataAccess.save()
    }
    
    func delete( _ entity:T) throws {
        try coreDataAccess.delete( entity )
    }
    
    func createIfNotExist( _ uniquePredicate: NSPredicate, setProperties:@escaping ((_ t:T) -> Void)) throws -> T {
        
        return try coreDataAccess.doInDb({(ctx) throws -> T? in
            
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
            fetchRequest.predicate = uniquePredicate
            let results = try ctx.fetch(fetchRequest)
            if ( !(results as! [NSManagedObject]).isEmpty ) {
                throw GenericRepositoryError.existingEntity
            }
            
            
            let newObject = T( context: ctx )
            setProperties( newObject );
            try ctx.save()
            return newObject;
        })!
    }
    
}

