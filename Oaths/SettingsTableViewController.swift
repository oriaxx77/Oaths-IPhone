//
//  SettingsTableViewController.swift
//  Oaths
//
//  Created by Bagyura Istvan on 19/09/16.
//  Copyright © 2016 p92. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath as NSIndexPath).row {
        case 1:
            findMeByCode()
        default:
            return
        }
        
    }
    
    func findMeByCode() {
        
        let dialog = UIAlertController(title: "Login", message: "Enter your code:", preferredStyle: .alert)
        dialog.addAction(UIAlertAction( title: "Login",
                                        style: .default,
                                        handler:{ (action: UIAlertAction) -> Void in
                                            if let code = dialog.textFields?.first!.text {
                                                self.showToast("Login button clicked: \(code)")
                                            }
                                        }))
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        dialog.addTextField{ (textField) -> Void in }
        self.present(dialog, animated: true, completion: nil)
    }
}
