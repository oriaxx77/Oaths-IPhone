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
    
    func showErrorDialog( _ message: String ){
        let alert = UIAlertController(title: "Hey", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToast( _ message: String ){
        self.view.makeToast( message, duration: 4.0, position:  .center )
    }
    
    func tryExec( _ action:() throws -> Void ){
        do {
            try action()
        }
        catch let error as NSError {
            self.showErrorDialog( "Error while loading oaths \(error), deails:\(error.userInfo)" )
        }
    }

}
