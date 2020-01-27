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

    func test_candidateNamedJohnDoe_hasCorrectValues() {
        // Given
        let firstName = "John"
        let lastName = "Doe"
        let identifier = 100
        
        // When
        let candidate = Candidate(identifier: identifier, firstName: firstName, lastName: lastName)
        
        // Then
        XCTAssertEqual(candidate.identifier, identifier)
        XCTAssertEqual(candidate.firstName, firstName)
        XCTAssertEqual(candidate.lastName, lastName)
    }
    
    func test_candidate_isCaseSensitive() {
        // Given
        let firstName = "John"
        let lastName = "Doe"
        
        // When
        let candidate = Candidate(identifier: 1, firstName: firstName, lastName: lastName)
        
        // Then
        XCTAssertNotEqual(candidate.firstName, "john")
        XCTAssertNotEqual(candidate.lastName, "doe")
    }
    
    func test_twoCandidatesWithSameNamesButDifferentIdentifier_areNotEqual() {
        // Given
        let firstName = "John"
        let lastName = "Doe"
        
        // When
        let candidate1 = Candidate(identifier: 1, firstName: firstName, lastName: lastName)
        let candidate2 = Candidate(identifier: 2, firstName: firstName, lastName: lastName)
        
        // Then
        XCTAssertNotEqual(candidate1, candidate2)
    }
}
