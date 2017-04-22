//
//  FirebaseAuthorizations.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias loginErrorHandler = (_ errorMessage: String?) -> Void

class FirebaseAuthorization: NSObject {
    
    static let instance = FirebaseAuthorization()
    private override init() {}
    
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
    
    func isUserLoggedIn() -> Bool {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            return true
        }
        else {
            
            return false
        }
        
    }
    
    func getUserID() -> String {
        return (FIRAuth.auth()?.currentUser?.uid) ?? ""
    }
    
    func getUserName() -> String {
        return (FIRAuth.auth()?.currentUser?.displayName) ?? ""
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
