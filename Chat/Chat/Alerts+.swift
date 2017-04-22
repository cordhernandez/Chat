//
//  Alerts.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation
import MobileCoreServices
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

extension ChatViewController {
    
    func createAlertForChatMediaMessages(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let photos = UIAlertAction(title: "Photos", style: .default) { (alert: UIAlertAction) in
            
            self.selectMediaType(type: kUTTypeImage)
            
        }
        
        let videos = UIAlertAction(title: "Videos", style: .default) { (alert: UIAlertAction) in
            
            self.selectMediaType(type: kUTTypeMovie)
        }
        
        alert.addAction(cancel)
        alert.addAction(photos)
        alert.addAction(videos)
        presentAlert(alert)
    }
    
}
