//
//  User.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/13/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import Foundation
import UIKit




struct ResponseMessages: Decodable {
    
    var response: [Message]?
}


struct Message:Decodable {
    
    var Timestamp: String?
    var idUser: NSInteger?
    var Message: String?
    
    
}


struct Response: Decodable {
    let user: User?
    let message: String?
    let token: String?
    var response: [Job]?
    
    
}



struct ResponseChat: Decodable {
    
    let response: [ChatWith]?

}


struct ChatWith: Decodable {
    let idChat: NSInteger?
    let RecruiterID: NSInteger?
    let StudentID: NSInteger?
    let RecruiterFirstName: String?
    let StudentFirstName: String?
    
}

struct Response2: Decodable {
    let message: String?
    var response: User?
        
}

struct Response3: Decodable {
    var response: [Uni]?
    
}


struct Response4: Decodable {
    var response: [Major]?
    
}



struct Uni: Decodable {
    let UnivName: String?
    let idUniversity: NSInteger?
    
}


struct Major: Decodable {
    let MajorName: String?
    let idMajor: NSInteger?

}


struct replyResponse: Decodable {
    let message: String?
    
}



struct User: Decodable {
    let EmailID: String?
    let LastName: String?
    let MiddleName: String?
    let FirstName: String?
    let Links: String?
    let Major: NSInteger?
    let PhoneNumber: String?
    let Skills: String?
    let University: NSInteger?
    let Bio: String?
    let Projects: String?
  //  let isAdmin: NSInteger?
    
    
}
