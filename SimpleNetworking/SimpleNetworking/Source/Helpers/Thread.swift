//
//  Thread.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

class Thread {
    static func main(_ block: @escaping () -> Void?) {
        DispatchQueue.main.async {
            block()
        }
    }
}
