//
//  UserModel.swift
//  Paths2
//
//  Created by Gina Holden on 4/3/16.
//  Copyright © 2016 Gina Holden. All rights reserved.
//

import Foundation

class User {
    class var sharedInstance: User {
        struct Static {
            static var instance: User?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = User()
        }
        
        return Static.instance!
    }
    
    var id = "NOT LOGGED IN"
    var name = "NO NAME"
}