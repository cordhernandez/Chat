    func signUpUserErrorHandler(with email: String, and password: String, loginErrorHandler: loginErrorHandler?) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user , error) in
            
            if error != nil {
                
                self.handleFirebaseErrors(firebaseError: error! as NSError, loginHandler: loginErrorHandler)
            }
            else {
                
                if user?.uid != nil {
                    
                    //store user to database
                    FireDatabase.instance.saveUserToDatabase(withID: user?.uid ?? "", email: email, password: password)
                    
                    //login the user 
                    self.loginUserErrorHandler(with: email, and: password, loginErrorHandler: loginErrorHandler)
                }
            }
        })
    }
    
    func loginUserErrorHandler(with email: String, and password: String, loginErrorHandler: loginErrorHandler?) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                
                self.handleFirebaseErrors(firebaseError: error! as NSError, loginHandler: loginErrorHandler)
            }
            else {
                
                loginErrorHandler?(nil)
            }
            
        })
        
    }
    
    func logOutUser() -> Bool {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            do {
                
                try FIRAuth.auth()?.signOut()
                return true
            }
            catch {
                return true
            }
            
        }
        
        return false
    }
    
}


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
