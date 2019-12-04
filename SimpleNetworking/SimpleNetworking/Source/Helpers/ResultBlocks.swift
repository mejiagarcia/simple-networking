//
//  ResultBlocks.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 2/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

public enum SNResult<T: Codable> {
    case success(response: T)
    case error(error: SNErrors)
}

public enum SNResultWithEntity<T: Codable, Y: Codable> {
    case success(response: T)
    case error(error: SNErrors)
    case errorResult(entity: Y)
}

public typealias SNResultBlock<T: Codable> = ((_ response: SNResult<T>) -> Void)?

public typealias SNResultBlockWithError<T: Codable, Y: Codable> = ((_ response: SNResultWithEntity<T, Y>) -> Void)?
