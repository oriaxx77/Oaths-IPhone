//
//  PeopleDataSource.swift
//  Oaths
//
//  Created by Bagyura Istvan on 15/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import Alamofire

class GenericDataSource<T>{
    
    private var entities = [T]()
    
    
    func getEntities() -> [T]{
        if entities.isEmpty {
            loadEntities()
        }
        return entities
    }
    
    func loadEntities(){
        // Override this to load the entities
    }
    
    
}
