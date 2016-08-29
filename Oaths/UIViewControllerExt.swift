//
//  UIViewControllerExt.swift
//  Oaths
//
//  Created by Bagyura Istvan on 15/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showErrorDialog( message: String ){
        let alert = UIAlertController(title: "Hey", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showToast( message: String ){
        self.view.makeToast( message, duration: 4.0, position: .Center)
    }
    
    func tryExec( action:() throws -> Void ){
        do {
            try action()
        }
        catch let error as NSError {
            self.showErrorDialog( "Error while loading oaths \(error), deails:\(error.userInfo)" )
        }
    }

}
