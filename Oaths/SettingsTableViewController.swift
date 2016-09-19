//
//  SettingsTableViewController.swift
//  Oaths
//
//  Created by Bagyura Istvan on 19/09/16.
//  Copyright © 2016 p92. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 1:
            findMeByCode()
        default:
            return
        }
        
    }
    
    func findMeByCode() {
        
        let dialog = UIAlertController(title: "Login", message: "Enter your code:", preferredStyle: .Alert)
        dialog.addAction(UIAlertAction( title: "Login",
                                        style: .Default,
                                        handler:{ (action: UIAlertAction) -> Void in
                                            if let code = dialog.textFields?.first!.text {
                                                self.showToast("Login button clicked: \(code)")
                                            }
                                        }))
        dialog.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        dialog.addTextFieldWithConfigurationHandler{ (textField) -> Void in }
        self.presentViewController(dialog, animated: true, completion: nil)
    }
}
