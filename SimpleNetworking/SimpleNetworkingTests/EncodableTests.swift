//
//  EncodableTests.swift
//  SimpleNetworkingTests
//
//  Created by Luis Carlos Mejia Garcia on 7/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import XCTest
@testable import SimpleNetworking

class EncodableTests: XCTestCase {
    
    func testEncodableToJSON() {
        let modelToConvert: Data? = MockData.TestModel.testInstance.toJSONData()
        
        XCTAssertNotNil(modelToConvert, "Unable to convert the given codable to Data.")
    }
}
