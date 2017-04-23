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

class ChatViewController: JSQMessagesViewController, MessageDataDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var timeStamp: JSQMessagesTimestampFormatter?
    private var messages: [JSQMessage] = []
    private let imagePicker = UIImagePickerController()
    
    fileprivate let async: OperationQueue = {
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        
        return operationQueue
    }()
    
    fileprivate let main = OperationQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        FirebaseDatabase.instance.messageDataDelegate = self
        getUserInformation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func onCancelButtonTapped(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func getUserInformation() {
        
        self.senderId = FirebaseAuthorization.instance.getUserID()
        self.senderDisplayName = FirebaseAuthorization.instance.getUserName()
        FirebaseDatabase.instance.observeUserMessages()
        FirebaseDatabase.instance.observeUserMediaMessages()
    }
    
    func messageDataReceived(senderID: String, senderName: String, text: String) {
        
        messages.append(JSQMessage(senderId: senderID, displayName: senderName, text: text))
        collectionView.reloadData()
    }
    
    func mediaDataReceived(senderID: String, senderName: String, url: String) {
        
        if let mediaURL = URL(string: url) {
            
            photoDataReceived(senderID: senderID, senderName: senderName, url: mediaURL)
        }
        else {
            
            let videoURL = URL(string: url)
            videoDataReceived(senderID: senderID, senderName: senderName, url: videoURL)
        }
    }
    
    func photoDataReceived(senderID: String, senderName: String, url: URL?) {
        
        guard let mediaURL = url else {
            return
        }
        
        let sdWebImageDownloader = SDWebImageDownloader.shared().downloadImage(with: mediaURL, options: [], progress: nil) { (image, data, error, finished) in
            
            self.main.addOperation {
                
                let jsqPhotoImage = JSQPhotoMediaItem(image: image)
                
                if senderID == self.senderId {
                    
                    jsqPhotoImage?.appliesMediaViewMaskAsOutgoing = true
                }
                else {
                    
                    jsqPhotoImage?.appliesMediaViewMaskAsOutgoing = false
                }
                
                self.messages.append(JSQMessage(senderId: senderID, displayName: senderName, media: jsqPhotoImage))
                self.collectionView.reloadData()
            }
        }
        
    }
    
    func videoDataReceived(senderID: String, senderName: String, url: URL?) {
        
        guard let mediaURL = url else {
            return
        }
        
        let jsqVideo = JSQVideoMediaItem(fileURL: mediaURL, isReadyToPlay: true)
        
        if senderID == self.senderId {
            
            jsqVideo?.appliesMediaViewMaskAsOutgoing = true
        }
        else {
            
            jsqVideo?.appliesMediaViewMaskAsOutgoing = false
        }
        
        self.messages.append(JSQMessage(senderId: senderID, displayName: senderName, media: jsqVideo))
        self.collectionView.reloadData()
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }
    
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
