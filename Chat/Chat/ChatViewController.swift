//
//  ChatViewController.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/21/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import AVKit
import Foundation
import JSQMessagesViewController
import MobileCoreServices
import UIKit
import SDWebImage
    fileprivate let async: OperationQueue = {
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        
        return operationQueue
    }()
    
    fileprivate let main = OperationQueue.main
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
        createAlertForChatMediaMessages(title: "Media Messages", message: "Please select a media")
    }
    
    func selectMediaType(type: CFString) {
        
        imagePicker.mediaTypes = [type as String]
        present(imagePicker, animated: true, completion: nil)
    }
    
}
