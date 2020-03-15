//
//  SN+DeleteMethods.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 15/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

// MARK: - PUT Methods
extension SN {
    
    public static func delete<T: Codable>(endpoint: String,
                                          model: Codable? = nil,
                                          onCompletion: SNResultBlock<T>) {
        
        SimpleNetworking.dataRequest(endpoint: endpoint,
                                     model: model,
                                     method: .delete,
                                     onCompletion: onCompletion)
    }
    
    public static func delete<T: Codable, Y: Codable>(endpoint: String,
                                                      model: Codable? = nil,
                                                      onCompletion: SNResultBlockWithError<T, Y>) {
        
        SimpleNetworking.dataRequestWithCustomResult(endpoint: endpoint,
                                                     model: model,
                                                     method: .delete,
                                                     onCompletion: onCompletion)
    }
}
