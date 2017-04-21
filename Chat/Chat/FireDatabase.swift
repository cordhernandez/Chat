//
//  FirebaseDatabase.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class FireDatabase: NSObject {
    
    static let instance = FireDatabase()
    private override init() {}
    
    var databaseReference: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var firebaseStorageReference: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: FirebaseStorageModel.storageReference)
    }
    
    func saveUserToDatabase(withID: String, email: String, password: String) {
        
        let data: Dictionary<String, Any> = [FirebaseDataModel.email : email,
                                             FirebaseDataModel.password : password]
        
        contactsReference.child(withID).setValue(data)
    }
    
}

//MARK: Firebase Database References
extension FireDatabase {
    
    var contactsReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.contacts)
    }
    
    var messagesReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.messages)
    }
    
    var mediaMessagesReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.mediaMessages)
    }
    
    var emailReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.email)
    }
    
    var passwordReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.password)
    }
    
    var dataReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.data)
    }
    
    var textReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.text)
    }
    
    var senderIDReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.senderID)
    }
    
    var senderNameReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.senderName)
    }
    
    var urlReference: FIRDatabaseReference {
        return databaseReference.child(FirebaseDataModel.url)
    }
    
}

//MARK: Firebase Storage References 
extension FireDatabase {
    
    var imageStorageReference: FIRStorageReference {
        return firebaseStorageReference.child(FirebaseStorageModel.imageStorage)
    }
    
    var videoStorageReference: FIRStorageReference {
        return firebaseStorageReference.child(FirebaseStorageModel.videoStorage)
    }
    
}
