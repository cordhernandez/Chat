//
//  Alerts.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func createAlertForUser(title: String, message: String)  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: title, style: .default, handler: nil)
        alert.addAction(ok)
        
        presentAlert(alert)
    }
    
    fileprivate func presentAlert(_ alert: UIAlertController) {
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
