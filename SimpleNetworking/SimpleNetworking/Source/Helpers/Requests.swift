//
//  Requests.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

class Requests {
    func getCreatedRequest(url: URL, model: Codable? = nil, method: RequestMethodTypes) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.allHTTPHeaderFields = SimpleNetworking.defaultHeaders as? [String : String]
        
        request.httpBody = model?.toJSONData()
        
        DebugMode.printRequest(request)
        
        return request
    }
}
