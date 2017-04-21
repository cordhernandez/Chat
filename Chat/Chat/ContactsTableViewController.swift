//
//  ChatMessagesTableViewController.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/20/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Firebase
import Foundation
import UIKit

class ContactsTableViewController: UITableViewController {
    
    var firebaseReference: FIRDatabaseReference!
    var firebaseHandle: FIRDatabaseHandle?
    var firebaseDataSnapshot: [FIRDataSnapshot] = []
