//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by DT on 8/23/20.
//  Copyright © 2020 DT. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    
    let success: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId
    }
    
}
