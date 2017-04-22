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
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as? JSQMessagesCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        let message = messages[indexPath.item]
        
        if message.senderId == self.senderId {
            
            return bubbleImageFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
        }
        else {
            
            return bubbleImageFactory?.incomingMessagesBubbleImage(with: UIColor.blue)
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        return JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "placeholder profile image"), diameter: 30)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        let message = messages[indexPath.item]
        
        if message.isMediaMessage {
            
            if let jsqVideoMediaItem = message.media as? JSQVideoMediaItem {
                
                let avPlayer = AVPlayer(url: jsqVideoMediaItem.fileURL)
                let avPlayerViewController = AVPlayerViewController()
                avPlayerViewController.player = avPlayer
                
                self.present(avPlayerViewController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        FirebaseDatabase.instance.saveUserMessageToDatabase(senderID: senderId, senderName: senderDisplayName, text: text)
        
        finishSendingMessage()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagePickerOriginalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let jpegData = UIImageJPEGRepresentation(imagePickerOriginalImage, 0.01)
            FirebaseDatabase.instance.saveUserMediaToDatbase(image: jpegData, video: nil, senderID: senderId, senderName: senderDisplayName)
        }
        else if let imagePickerMediaURL = info[UIImagePickerControllerMediaURL] as? URL {
            
            FirebaseDatabase.instance.saveUserMediaToDatbase(image: nil, video: imagePickerMediaURL, senderID: senderId, senderName: senderDisplayName)
        }
        
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
        createAlertForChatMediaMessages(title: "Media Messages", message: "Please select a media")
    }
    
    func selectMediaType(type: CFString) {
        
        imagePicker.mediaTypes = [type as String]
        present(imagePicker, animated: true, completion: nil)
    }
    
}
