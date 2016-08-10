//
//  Friend+CoreDataProperties.swift
//  Oaths
//
//  Created by Bagyura Istvan on 10/08/16.
//  Copyright © 2016 p92. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Friend {

    @NSManaged var email: String?
    @NSManaged var firstName: String?
    @NSManaged var surName: String?

}
