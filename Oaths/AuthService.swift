//
//  Auth.swift
//  Oaths
//
//  Created by Bagyura Istvan on 24/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import Alamofire

class AuthService{
    
    func auth( withEmail email: String ){
        
        // TODO: remove the constant bodyObject
        Alamofire.Manager.request(.PUT, K.EndpointUrls.AuthUrl, bodyObject: email )
            .responseString( completionHandler: { (response) -> Void in
                
                guard response.result.isSuccess else {
                    print( "Error while login to server: \(response.result.error)")
                    return
                }
                
                print( "Auth Token: \(response.result.value)")
                
                
            
        });
    
        
    }

}
