//
//  SignUpViewController.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class SignUpViewController: UIViewController {

    @IBOutlet weak var signupEmailTextField: UITextField!
    @IBOutlet weak var signupPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onContinueButtonTapped(_ sender: UIButton) {
        
        signUpUser()
    }
    
    func signUpUser() {
        
        if signupEmailTextField.text != "" && signupPasswordTextField.text != "" {
            
            FirebaseAuthorization.instance.signUpUserErrorHandler(with: signupEmailTextField.text ?? "", and: signupPasswordTextField.text ?? "", loginErrorHandler: { (message) in
                
                if message != nil {
                    self.createAlertForUser(title: "Problem creating your user account", message: message ?? "")
                }
                else {
                    
                    self.goToContactsFromSignup()
                }
                
            })
            
        }
        else {
            
            createAlertForUser(title: "Email and Password Required", message: "Please enter an email and a password")
        }
    }
    
}


//MARK: Segues
extension SignUpViewController {
    
    func goToContactsFromSignup() {
        
        performSegue(withIdentifier: "signupToContactsSegue", sender: nil)
    }
    
}
