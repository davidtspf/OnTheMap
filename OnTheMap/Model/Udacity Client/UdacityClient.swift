//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by DT on 8/22/20.
//  Copyright © 2020 DT. All rights reserved.
//

import Foundation
import UIKit

class UdacityClient: UIViewController, UITextViewDelegate {
        
    struct Auth {
        static var sessionId: String? = nil
        static var userId = ""
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getUserProfile
        case login
        
        var stringValue: String {
            switch self {
            case .getUserProfile:
                return Endpoints.base + "/users/" + Auth.userId
            case .login:
                return Endpoints.base + "/session"
            }
        }
            
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, apiType: String, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if apiType == "Udacity" {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                completion(nil, error)
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                if apiType == "Udacity" {
                    let range = (5..<data.count)
                    let newData = data.subdata(in: range) /* subset response data! */
                    let responseObject = try decoder.decode(ResponseType.self, from: newData)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }

    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, apiType: String, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        
        if apiType == "Udacity" {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                completion(nil, error)
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                if apiType == "Udacity" {
                    let range = (5..<data.count)
                    let newData = data.subdata(in: range) /* subset response data! */
                    let responseObject = try decoder.decode(ResponseType.self, from: newData)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        
        let encoder = JSONEncoder()
        
        let request = AuthenticationRequestType(username: username, password: password)
        let udacityRequest = UdacityRequestType(udacity: request)
        let body = try? encoder.encode(udacityRequest)
        
        taskForPOSTRequest(url: Endpoints.login.url, apiType: "Udacity", responseType: SessionResponse.self, body: body) { (response, error) in
            if let response = response {
                print("hello 9")
                Auth.sessionId = response.session.id
                Auth.userId = response.account.userId
                getUserProfile(completion: { (success, error) in
                    if success {
                        print("User's profile retrieved.")
                    }
                })
                completion(true, nil)
            } else {
                print("hello 10")
                completion(false, error)
            }
        }
    }
    
    class func getUserProfile(completion: @escaping (Bool, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getUserProfile.url, apiType: "Udacity", responseType: UserProfile.self) { (response, error) in
            if let response = response {
                print("First Name: \(response.firstName) && Last Name: \(response.lastName) && Full Name: \(response.nickname)")
                Auth.firstName = response.firstName
                Auth.lastName = response.lastName
                completion(true, nil)
            } else {
                print("Failed to get user's profile.")
                completion(false, error)
            }
        }
    }
    
}
