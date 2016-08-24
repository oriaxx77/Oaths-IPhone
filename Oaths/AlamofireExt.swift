//
//  AlamofireExt.swift
//  Oaths
//
//  Created by Bagyura Istvan on 24/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Alamofire
import EVReflection


// Extend Alamofire so it can do POSTs with a JSON body from passed object
// Alamofire.Manager.request(.POST, endpointUrlString, bodyObject: myObjectToPost)
extension Alamofire.Manager {
    public class func request(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          bodyObject: EVObject)
        -> Request
    {
        return Manager.sharedInstance.request(
            method,
            URLString,
            parameters: [:],
            encoding: .Custom({ (convertible, params) in
                let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
                mutableRequest.HTTPBody = bodyObject.toJsonString().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                return (mutableRequest, nil)
            })
        )
    }
    
    public class func request(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          bodyObject: String)
        -> Request
    {
        return Manager.sharedInstance.request(
            method,
            URLString,
            parameters: [:],
            encoding: .Custom({ (convertible, params) in
                let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
                mutableRequest.HTTPBody = bodyObject.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                return (mutableRequest, nil)
            })
        )
    }
}
