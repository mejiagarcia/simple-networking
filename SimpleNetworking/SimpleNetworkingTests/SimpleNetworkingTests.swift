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
    
    private var getCallExpectation = XCTestExpectation(description: "GET")
    
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
    
    func testGETRequest() {
        let endpoint = "https://jsonplaceholder.typicode.com/todos/1"
        var modelRecieved: MockData.User?
        
        SN.get(endpoint: endpoint) { [weak self] (response: SNResult<MockData.User>) in
            switch response {
            case .error(let error):
                XCTFail(error.localizedDescription)
                
            case .success(let model):
                modelRecieved = model
            }
            
            self?.getCallExpectation.fulfill()
        }
        
        wait(for: [getCallExpectation], timeout: 3)
        
        XCTAssert(modelRecieved?.userId == 1, "Unable to get expected parsed integer.")
        XCTAssert(modelRecieved?.title == "delectus aut autem", "Unable to get expected parsed string.")
    }
    
    func testGETRequestErrors() {
        let endpoint = "https://jsonplaceholder.typicode.com/todos"
        
        SN.get(endpoint: endpoint) { [weak self] (response: SNResult<MockData.User>) in
            switch response {
            case .error(let error):
                switch error {
                case .badResponse:
                    print(error)
                    
                case .custom:
                    print(error)
                    
                case .emptyContent:
                    print(error)
                    
                case .endpoint:
                    print(error)
                    
                case .unknown:
                    print(error)
                }
                
            default:
                break
            }
            
            self?.getCallExpectation.fulfill()
        }
        
        wait(for: [getCallExpectation], timeout: 3)
    }
}
