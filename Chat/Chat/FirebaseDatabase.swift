    func observeUserMediaMessages() {
        
        mediaMessagesReference.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            guard let data = snapshot.value as? NSDictionary else {
                return
            }
            
            guard let senderID = data[FirebaseDataModel.senderID] as? String else {
                return
            }
            
            guard let senderName = data[FirebaseDataModel.senderName] as? String else {
                return
            }
            
            guard let fileURL = data[FirebaseDataModel.url] as? String else {
                return
            }
            
            
        }
    }
    
    func goLoadContacts() {
        
        var contactsArray: [FirebaseContactsModel] = []
        
        contactsReference.observeSingleEvent(of: FIRDataEventType.value) { (snapshot: FIRDataSnapshot) in
            
            guard let myContacts = snapshot.value as? NSDictionary else {
                return
            }
            
            for (key, value) in myContacts {
                
                guard let contactData = value as? NSDictionary else {
                    continue
                }
                
                guard let email = contactData[FirebaseDataModel.email] as? String else {
                    continue
                }
                
                let id = key as? String
                let newContact = FirebaseContactsModel(name: id ?? "", id: email)
                contactsArray.append(newContact)
            }
            
            self.contactDataDelegate?.contactDataReceived(contacts: contactsArray)
        }
        
    }
    
}

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
