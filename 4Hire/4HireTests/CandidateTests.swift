//
//  CandidateTests.swift
//  4HireTests
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import XCTest
@testable import _Hire

class CandidateTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CandidateNamedJohnDoe_hasCorrectValues() {
        // Given
        let firstName = "John"
        let lastName = "Doe"
        
        // When
        let candidate = Candidate(firstName: firstName, lastName: lastName)
        
        // Then
        XCTAssertEqual(candidate.firstName, firstName)
        XCTAssertEqual(candidate.lastName, lastName)
    }
}
