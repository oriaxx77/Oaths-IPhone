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
    
    func auth( email email: String,
               completionHandler: (String) -> Void ){
        
        // TODO: remove the constant bodyObject
        Alamofire.Manager.request(.PUT, K.EndpointUrls.AuthUrl, bodyObject: email )
            .responseString( completionHandler: { (response) -> Void in
                
                guard response.result.isSuccess else {
                    print( "Error while login to server: \(response.result.error)")
                    return
                }
                
                print( "Auth Token: \(response.result.value)")
                if let authToken = response.result.value {
                    completionHandler( authToken )
                }
        });
        
    }
    
    
    func registerPushNotificationDeviceToken(  deviceToken deviceToken: String,
                                               withAuthToken authToken: String ) {
        
        
        Alamofire.request(.POST, K.EndpointUrls.RegisterDeviceTokenUrl ,parameters: ["authToken": authToken, "deviceToken": deviceToken])
            .responseString{ (response) -> Void in
                
                guard response.result.isSuccess else {
                    print("Error while registering push notification device token on Oaths server: \(response.result.error)")
                    return
                }
                
                /*
                 TODO: handle success?
                guard let value = response.result.value as? [String: AnyObject],
                    rows = value["people"] as? [[String:AnyObject]]else {
                        print("Malformed people data received from server: \(response.result.value)")
                        return
                }
                */
                
        } ;
        
    }
    

}
