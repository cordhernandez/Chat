//
//  ViewController.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

//MARK: Segues
extension LogInViewController {
    
    func goToContactsFromLogin() {
        
        performSegue(withIdentifier: "loginToContactsSegue", sender: nil)
    }
    
    func goToSignUp() {
        
        performSegue(withIdentifier: "toSignUpSegue", sender: nil)
    }
    
    
}

