//
//  SimpleNetworking.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 2/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

public class SimpleNetworking {
    // MARK: - Properties
    public static var currentTask: URLSessionTask?
    public static let decoder = JSONDecoder()
    public static let session = URLSession.shared
    
    public static var defaultHeaders: NSMutableDictionary = [
        "Content-Type": "application/json"
    ]
    
    // MARK: - Public Methods
    public static func stop() {
        SimpleNetworking.currentTask?.cancel()
    }
    
    public static func setAuthenticationHeader(prefix: String, token: String) {
        SimpleNetworking.defaultHeaders["Authentication"] = "\(prefix) \(token)"
    }
}
