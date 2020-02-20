//
//  ValidatorTests.swift
//  SimpleNetworkingTests
//
//  Created by Luis Carlos Mejia Garcia on 8/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import XCTest
@testable import SimpleNetworking

class ValidatorTests: XCTestCase {

    func testSuccessValidation() {
        let isValidResponse = SimpleNetworkingValidator.isValidStatusCode(response: MockData.successResponse)
        
        XCTAssertTrue(isValidResponse, "Validator is not working for status code 200.")
    }
    
    func testErrorValidation() {
       let isValidResponse = SimpleNetworkingValidator.isValidStatusCode(response: MockData.errorResponse)
           
       XCTAssertFalse(isValidResponse, "Validator is working for invalid staus code! :(")
   }
    
    func testNilResponseValidation() {
        let isValidResponse = SimpleNetworkingValidator.isValidStatusCode(response: nil)
                 
         XCTAssertFalse(isValidResponse, "Validator is working for nil responses! :(")
    }
    
    func testInvalidValidation() {
        let isValidResponse = SimpleNetworkingValidator.isValidStatusCode(response: nil)
             
        XCTAssertFalse(isValidResponse, "Validator is working for invalid response! :(")
    }
}
