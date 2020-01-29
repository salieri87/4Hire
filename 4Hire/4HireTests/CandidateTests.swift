//
//  CandidateTests.swift
//  4HireTests
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

@testable import _Hire
import XCTest

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

    // MARK: - Position

    func test_position_hasCorrectValues() {
        // Given
        let name = "iOS Developer"
        let company = "HSBC"
        let startedAt = Date.distantPast
        let finishedAt = Date(timeInterval: 10000, since: startedAt)
        let jobDescription = "Coding super banking app"

        // When
        let position = Position(name: name, company: company, startedAt: startedAt, finishedAt: finishedAt, jobDescription: jobDescription)

        // Then
        XCTAssertEqual(position.name, "iOS Developer")
        XCTAssertEqual(position.company, "HSBC")
        XCTAssertEqual(position.startedAt, Date.distantPast)
        XCTAssertEqual(position.finishedAt, finishedAt)
        XCTAssertEqual(position.jobDescription, "Coding super banking app")
    }

    // MARK: - Education

    func test_education_hasCorrectValues() {
        // Given
        let school = "University Of iOS Development"
        let startedAt = Date.distantPast
        let finishedAt: Date? = nil
        let course = "Apple technologies"

        // When
        let study = Education(school: school, startedAt: startedAt, finishedAt: finishedAt, course: course)

        // Then
        XCTAssertEqual(study.school, "University Of iOS Development")
        XCTAssertEqual(study.startedAt, Date.distantPast)
        XCTAssertNil(study.finishedAt)
        XCTAssertEqual(study.course, "Apple technologies")
    }

    // MARK: - Decodable

    func test_decodingValidCandidate_succeeds() {
        // Given
        guard let url = Bundle(for: type(of: self)).url(forResource: "candidate_test", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
            XCTFail("Failed to obtain json data")
            return
        }

        do {
            // When
            let models = try JSONDecoder().decode(ResponseRoot.self, from: data)
            let candidate = models.data

            // Then
            XCTAssertEqual(candidate, Mocks.stubModel())
            
            // Checking experience and education, as they are not involved in `Candidate`'s equality!
            XCTAssertEqual(candidate.experience?.first?.company, "cool company name")
            XCTAssertEqual(candidate.experience?.first?.name, "iOS developer")
            XCTAssertEqual(candidate.experience?.first?.jobDescription, "some description")
            
            XCTAssertEqual(candidate.education?.first?.school, "Such Cool University")
            XCTAssertEqual(candidate.education?.first?.course, "Applied Awesomness")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_decodingInvalidCandidate_failsWithParsingFailedError() {
        // Given
        guard let url = Bundle(for: type(of: self)).url(forResource: "candidate_malformed", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
            XCTFail("Failed to obtain json data")
            return
        }

        // Then
        XCTAssertThrowsError(try JSONDecoder().decode(ResponseRoot.self, from: data), "Should throw failed parsing error")
    }
}
