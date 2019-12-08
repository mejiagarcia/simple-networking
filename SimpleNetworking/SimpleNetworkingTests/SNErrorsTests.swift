//
//  SNErrorsTests.swift
//  SimpleNetworkingTests
//
//  Created by Luis Carlos Mejia Garcia on 7/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import XCTest
@testable import SimpleNetworking

class SNErrorsTests: XCTestCase {

    func testLocalizedDescription() {
        let types: [SNErrors] = [
            .badResponse,
            .custom(error: nil),
            .emptyContent,
            .endpoint,
            .unknown(error: nil)
        ]
        
        types.forEach {
            if $0.localizedDescription.isEmpty {
                XCTFail("\(String(describing: $0)) localizedDescription is empty!")
            }
        }
    }
}
