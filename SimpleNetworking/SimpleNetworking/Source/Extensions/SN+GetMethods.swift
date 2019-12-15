//
//  SimpleNetworking+GetMethods.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

// MARK: - GET Methods
extension SN {
    
    public static func get<T: Codable>(endpoint: String,
                                       onCompletion: SNResultBlock<T>) {
        
        SimpleNetworking.request(endpoint: endpoint,
                                 method: .get,
                                 onCompletion: onCompletion)
    }
    
    public static func get<T: Codable, Y: Codable>(endpoint: String,
                                                   onCompletion: SNResultBlockWithError<T, Y>) {
        
        SimpleNetworking.requestWithCustomResult(endpoint: endpoint,
                                                 method: .get,
                                                 onCompletion: onCompletion)
    }
}
