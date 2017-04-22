
//MARK: Firebase Database References
extension FirebaseDatabase {
    
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
extension FirebaseDatabase {
    
    var imageStorageReference: FIRStorageReference {
        return firebaseStorageReference.child(FirebaseStorageModel.imageStorage)
    }
    
    var videoStorageReference: FIRStorageReference {
        return firebaseStorageReference.child(FirebaseStorageModel.videoStorage)
    }
    
}
