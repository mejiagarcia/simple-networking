//
//  RequestsTests.swift
//  SimpleNetworkingTests
//
//  Created by Luis Carlos Mejia Garcia on 7/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import XCTest
@testable import SimpleNetworking

class RequestsTests: XCTestCase {
    private let requestMaker = Requests()
    
    func testSimpleRequestCreation() {
        let request = requestMaker.getCreatedRequest(url: MockData.requestUrl, method: .get)
        
        XCTAssertEqual(request.httpMethod, RequestMethodTypes.get.value, "Unable to validate method from the created request.")
        XCTAssertEqual(request.url, MockData.requestUrl, "Unable to validate URL from the created request.")
    }
    
    func testRequestWithBodyCreation() {
        let model = MockData.TestModel.testInstance
        let request = requestMaker.getCreatedRequest(url: MockData.requestUrl, model: model, method: .post)
        
        XCTAssertEqual(request.httpMethod, RequestMethodTypes.post.value, "Unable to validate method from the created request.")
        XCTAssertEqual(request.url, MockData.requestUrl, "Unable to validate URL from the created request.")
        XCTAssertEqual(request.httpBody, model.toJSONData(), "Unable to validate the given model from the created request.")
    }
    
    func testRequestHeaders() {
        let request = requestMaker.getCreatedRequest(url: MockData.requestUrl, method: .get)

        XCTAssertEqual(request.allHTTPHeaderFields,
                       MockData.DefaultHeaders as? [String : String],
                       "Unable to validate headers from the created request.")
    }
}
