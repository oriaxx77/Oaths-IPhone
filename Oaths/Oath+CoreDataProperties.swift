//
//  Oath+CoreDataProperties.swift
//  Oaths
//
//  Created by Bagyura Istvan on 06/07/16.
//  Copyright © 2016 p92. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Oath {

    @NSManaged var creationDate: Date?
    @NSManaged var oath: String?
    @NSManaged var temptationFailed: NSNumber?
    @NSManaged var temptationResisted: NSNumber?

}
