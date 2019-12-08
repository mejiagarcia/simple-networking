//
//  RequestMethodTypes.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

enum RequestMethodTypes: String, CaseIterable {
    case get
    case post
    case put
    case delete
    
    var value: String {
        return self.rawValue.uppercased()
    }
}
