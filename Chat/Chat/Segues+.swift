//
//  Segues+.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/21/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func goToSignUp() {
        
        performSegue(withIdentifier: "toSignUpSegue", sender: nil)
    }
    
    func goToChatViewController() {
        
        performSegue(withIdentifier: "toChatSegue", sender: nil)
    }
    
    func goToContactsFromLogin() {
        
        performSegue(withIdentifier: "loginToContactsSegue", sender: nil)
    }
    
    func goToContactsFromSignup() {
        
        performSegue(withIdentifier: "signupToContactsSegue", sender: nil)
    }
    
}
