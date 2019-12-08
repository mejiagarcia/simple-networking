//
//  ThreadsTests.swift
//  SimpleNetworkingTests
//
//  Created by Luis Carlos Mejia Garcia on 8/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import XCTest
@testable import SimpleNetworking

class ThreadsTests: XCTestCase {

    func testMainThreadCalling() {
        Thread.main {
            XCTAssertTrue(Thread.isMainThread, "Method is not being called in the main thread! check this out asap!")
        }
    }
}
