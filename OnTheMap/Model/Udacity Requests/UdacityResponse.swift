//
//  UdacityResponse.swift
//  OnTheMap
//
//  Created by DT on 8/23/20.
//  Copyright © 2020 DT. All rights reserved.
//

import Foundation

struct UdacityResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case statusMessage
    }
}

extension UdacityResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
