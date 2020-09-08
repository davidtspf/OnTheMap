//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by DT on 8/23/20.
//  Copyright © 2020 DT. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    
    let account: Account
    let session: Session
     
    enum CodingKeys: String, CodingKey {
        case account
        case session
    }
    
    struct Account: Codable {
        let registered: Bool
        let userId: String
    }
    
    struct Session: Codable {
        let id: String
        let expiration: String
    }
    
    
    /*
    let success: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId
    }
    */
}
