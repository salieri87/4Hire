//
//  LocalNetworkingManagerTests.swift
//  4HireTests
//
//  Created by Filip Chwastowski on 28/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import XCTest
@testable import _Hire

class LocalNetworkingManagerTests: XCTestCase {
    
    let networkingResponseTimeout = 0.1

    func test_requestData_fromExistingResource_returnsExpectedData() {
        // Given
        let manager = LocalNetworkingManager.sharedManager
        guard let url = Bundle(for: LocalNetworkingManagerTests.self).url(forResource: "candidate_test", withExtension: "json") else {
            XCTFail("Seems like test resource is missing.")
            return
        }
        
        // When
        let expectation = self.expectation(description: "Manager should fetch same data as in stub")
        manager.requestData(from: url) { (result) in
            if case let .success(model) = result {
                // Then
                let candidate = try! JSONDecoder().decode(Candidate.self, from: model)
                XCTAssertEqual(candidate, self.stubModel())
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        waitForExpectations(timeout: networkingResponseTimeout, handler: nil)
    }
    
    func test_requestData_fromMalformedResource_failsWithError() {
        // Given
        let manager = LocalNetworkingManager.sharedManager
        guard let url = Bundle(for: LocalNetworkingManagerTests.self).url(forResource: "candidate_malformed", withExtension: "json") else {
            XCTFail("Seems like test resource is missing.")
            return
        }
        
        // When
        let expectation = self.expectation(description: "Manager should fail when fetching malformed data.")
        manager.requestData(from: url) { (result) in
            if case let .failure(error) = result {
                // Then
                XCTAssertEqual(error, .parsingFailed)
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        waitForExpectations(timeout: networkingResponseTimeout, handler: nil)
    }
}
