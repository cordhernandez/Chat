//
//  ViewController.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import FirebaseAuth
import Foundation
import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        checkIfUserIsStillLoggedInFromLoginVC()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        
        loginInUser()
    }
    
    @IBAction func onSignup(_ sender: UIButton) {
        
        goToSignUp()
    }
    
    func loginInUser() {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            FirebaseAuthorization.instance.loginUserErrorHandler(with: emailTextField.text ?? "", and: passwordTextField.text ?? "", loginErrorHandler: { (message) in
                
                if message != nil {
                    self.createAlertForUser(title: "Problem with Authentication", message: message ?? "")
                }
                else {
                    self.goToContactsFromLogin()
                }
                
            })
            
        }
        else {
            
            createAlertForUser(title: "Email and Password Required", message: "Please enter an email and a password")
        }
        
    }
    
}


