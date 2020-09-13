//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by DT on 8/22/20.
//  Copyright © 2020 DT. All rights reserved.
//

import Foundation

struct UdacityRequestType: Codable {
    var udacity: AuthenticationRequestType
}

struct AuthenticationRequestType: Codable {
    var username: String
    var password: String
}
