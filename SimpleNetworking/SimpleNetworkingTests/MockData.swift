//
//  MockData.swift
//  SimpleNetworkingTests
//
//  Created by Luis Carlos Mejia Garcia on 7/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

struct MockData {
    struct TestModel: Codable {
        let name: String
        let age: Int
        let isActive: Bool
        
        static var testInstance: TestModel {
            return TestModel(name: "carlos", age: 24, isActive: true)
        }
    }
    
    struct User: Codable {
        let title: String
        let userId: Int
        
        static var testInstance: User {
             return User(title: "test title", userId: 1)
         }
    }
    
    static let DefaultHeaders: NSMutableDictionary = [
        "Content-Type": "application/json"
    ]
    
    static let errorResponse = HTTPURLResponse(url: MockData.requestUrl, statusCode: 401, httpVersion: nil, headerFields: nil)
    
    static let successResponse = HTTPURLResponse(url: MockData.requestUrl, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static let requestUrl = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
    
    struct AuthenticationHeader {
        static let prefix = "Bearer"
        static let key = "Authorization"
        static let token = "TOKEN"
        static let value = "Bearer TOKEN"
    }
}
