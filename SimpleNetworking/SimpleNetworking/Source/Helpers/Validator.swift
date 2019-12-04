//
//  Validator.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

class SimpleNetworkingValidator {
    static func isValidStatusCode(response: URLResponse?) -> Bool {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return false
        }
        
        return 200 ... 299 ~= statusCode
    }
}
