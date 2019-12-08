//
//  RequestMethodTypesTests.swift
//  SimpleNetworkingTests
//
//  Created by Luis Carlos Mejia Garcia on 7/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import XCTest
@testable import SimpleNetworking

class RequestMethodTypesTests: XCTestCase {

    func testTypeValue() {
        let expectedValues = [
            "GET",
            "POST",
            "PUT",
            "DELETE"
        ]
        
        let values: [String] = RequestMethodTypes.allCases.map { $0.value }
        
        XCTAssertEqual(values, expectedValues, "Unable to get the expected list of values.")
    }
}
