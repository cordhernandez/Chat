//
//  FirebaseContactsModel.swift
//  Chat
//
//  Created by Cordero Hernandez on 4/21/17.
//  Copyright © 2017 Cordero. All rights reserved.
//

import Foundation

struct FirebaseContactsModel {
    
    private var newName: String
    private var newID: String
    
    init(name: String, id: String) {
        newName = name
        newID = id
    }
    
    var name: String {
        return newName
    }
    
    var id: String {
        return newID
    }
    
}

