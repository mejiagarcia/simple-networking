//
//  Requests.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

class Requests {
    static func getCreatedRequest(url: URL, model: Codable? = nil, method: RequestMethodTypes) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        
        SimpleNetworking.defaultHeaders.forEach {
            request.setValue($0.value as? String, forHTTPHeaderField: $0.key as? String ?? "")
        }
        
        request.httpBody = model?.toJSONData()
        
        return request
    }
}
