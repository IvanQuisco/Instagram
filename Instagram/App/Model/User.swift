//
//  User.swift
//  Instagram
//
//  Created by Ivan Quintana on 16/08/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import Foundation


struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
