//
//  PostSession.swift
//  OnTheMap
//
//  Created by DT on 8/23/20.
//  Copyright © 2020 DT. All rights reserved.
//

import Foundation

struct PostSession: Codable {
    
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case requestToken
    }
    
}
