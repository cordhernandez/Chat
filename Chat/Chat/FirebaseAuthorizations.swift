//MARK: Firebase Error Handling
extension FirebaseAuthorization {
    
    func handleFirebaseErrors(firebaseError: NSError, loginHandler: loginErrorHandler?) {
        
        if let firebaseErrorCode = FIRAuthErrorCode(rawValue: firebaseError.code) {
            
            switch firebaseErrorCode {
                
            case .errorCodeEmailAlreadyInUse:
                loginHandler?(FirebaseErrorMessages.emailAlreadyInUse)
                break
                
            case .errorCodeInvalidEmail:
                loginHandler?(FirebaseErrorMessages.invalidEmail)
                break
                
            case .errorCodeUserNotFound:
                loginHandler?(FirebaseErrorMessages.userNotFound)
                break
                
            case .errorCodeWrongPassword:
                loginHandler?(FirebaseErrorMessages.wrongPassword)
                break
                
            case .errorCodeWeakPassword:
                loginHandler?(FirebaseErrorMessages.weakPassword)
                break
                
            default :
                break
                
            }
            
        }
        
    }
    
}
