//
//  Errors.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 2/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

public enum SNErrors: Error {
    case endpoint
    case badResponse
    case custom(error: Error?)
    case emptyContent
    case unknown(error: String?)
    
    var localizedDescription: String {
        let unknownError = "Unknown error."
        
        switch self {
        case .endpoint:
            return "Unable to convert the endpoint."
            
        case .badResponse:
            return "Unable to determinate a success response."
            
        case .custom(let error):
            return error?.localizedDescription ?? unknownError
            
        case .emptyContent:
            return "Empty content"
            
        case .unknown(let error):
            return error ?? unknownError
        }
    }
}
