//
//  PeopleDataSource.swift
//  Oaths
//
//  Created by Bagyura Istvan on 15/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import Alamofire

class PeopleDataSource{
    
    private var people = [Person]()
    
    func getPeople() -> [Person]{
        if people.isEmpty {
            loadPeople()
        }
        return people
    }
    
    private func loadPeople(){
        Alamofire.request(.GET,"http://127.0.0.1:8080/person")
            .responseJSON{ (response) -> Void in
                
                guard response.result.isSuccess else {
                    print("Error while fetching people from server: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject],
                    rows = value["people"] as? [[String:AnyObject]]else {
                        print("Malformed people data received from server: \(response.result.value)")
                        return
                }
                
                
                self.people = [Person]()
                for personDict in rows {
                    
                    self.people.append( Person(json: personDict))
                    print( "person added " )
                }
                
                
                print( "Response: \(value)")
                print( "ResponsePerson : \(self.people)")
                
        } ;
    }
    
    
}
