//
//  SimpleNetworking+PostMethods.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

// MARK: - POST Methods
extension SN {
    
    public static func post<T: Codable>(endpoint: String,
                                        model: Codable? = nil,
                                        onCompletion: SNResultBlock<T>) {
        
        SimpleNetworking.dataRequest(endpoint: endpoint,
                                     model: model,
                                     method: .post,
                                     onCompletion: onCompletion)
    }
    
    public static func post<T: Codable, Y: Codable>(endpoint: String,
                                                    model: Codable? = nil,
                                                    onCompletion: SNResultBlockWithError<T, Y>) {
        
        SimpleNetworking.dataRequestWithCustomResult(endpoint: endpoint,
                                                     model: model,
                                                     method: .post,
                                                     onCompletion: onCompletion)
    }
}
