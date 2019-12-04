//
//  Encodable+Extensions.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
