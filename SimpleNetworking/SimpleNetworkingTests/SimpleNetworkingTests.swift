//
//  SimpleNetworkingTests.swift
//  SimpleNetworkingTests
//
//  Created by Luis Carlos Mejia Garcia on 8/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import XCTest
@testable import SimpleNetworking

class SimpleNetworkingTests: XCTestCase {

    func testPerformanceExample() {
        SimpleNetworking.defaultHeaders.removeAllObjects()
        
        SimpleNetworking.setAuthenticationHeader(prefix: MockData.AuthenticationHeader.prefix,
                                                 token: MockData.AuthenticationHeader.token)
        
        let expectedKeyInHeader: String = (SimpleNetworking.defaultHeaders as? [String: String])?.first?.key ?? ""
        let expectedValueInHeader: String = (SimpleNetworking.defaultHeaders as? [String: String])?.first?.value ?? ""
        
        XCTAssertEqual(expectedKeyInHeader, MockData.AuthenticationHeader.key, "Unable to get expected key.")
        XCTAssertEqual(expectedValueInHeader, MockData.AuthenticationHeader.value, "Unable to get expected value.")
    }
    
    func testStopRequest() {
        SimpleNetworking.currentTask = URLSession.shared.dataTask(with: MockData.requestUrl)
        SimpleNetworking.stop()
        
        XCTAssertEqual(SimpleNetworking.currentTask?.state, .canceling, "Current task isn't cancelled, so is not being stopped.")
    }
}
