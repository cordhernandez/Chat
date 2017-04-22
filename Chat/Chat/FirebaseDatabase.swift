//MARK: Firebase Storage References
extension FirebaseDatabase {
    
    var imageStorageReference: FIRStorageReference {
        return firebaseStorageReference.child(FirebaseStorageModel.imageStorage)
    }
    
    var videoStorageReference: FIRStorageReference {
        return firebaseStorageReference.child(FirebaseStorageModel.videoStorage)
    }
    
}
