//
//  FirebaseAuthorizations+.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/21/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func checkIfUserIsStillLoggedInFromLoginVC() {
        
        if FirebaseAuthorization.instance.isUserLoggedIn() {
            
            goToContactsFromLogin()
        }
        
    }
    
    func checkIfUserIsStillLoggedInFromSignUpVC() {
        
        if FirebaseAuthorization.instance.isUserLoggedIn() {
            
            goToContactsFromSignup()
        }
        
    }
    
}
