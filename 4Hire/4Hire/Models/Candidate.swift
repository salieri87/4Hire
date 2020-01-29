//
//  Candidate.swift
//  4Hire
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

/// Model structure of candidate's details.
struct Candidate: Decodable, Equatable {
    var identifier: Int
    var firstName: String
    var lastName: String
    /// List of past and current roles.
    var experience: [Position]?
    /// List of past and current studies.
    var education: [Education]?
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName
    }
}

/// Wrapper for job position.
struct Position: Decodable {
    var name: String
    var company: String
    var startedAt: Date
    var finishedAt: Date?
    var jobDescription: String
    
    enum Error: Swift.Error {
        case failedParsingDate
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case company
        case startedAt
        case finishedAt
        case jobDescription
    }
    
    init(name: String, company: String, startedAt: Date, finishedAt: Date? = nil, jobDescription: String) {
        self.name = name
        self.company = company
        self.startedAt = startedAt
        self.finishedAt = finishedAt
        self.jobDescription = jobDescription
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        company = try container.decode(String.self, forKey: .company)
        let startedAtString = try container.decode(String.self, forKey: .startedAt)
        startedAt = try Position.date(from: startedAtString)
        let finishedAtString = try container.decodeIfPresent(String.self, forKey: .finishedAt)
        finishedAt = finishedAtString != nil ? try Position.date(from: finishedAtString!) : nil
        jobDescription = try container.decode(String.self, forKey: .jobDescription)
    }
    
    static func date(from dateString: String) throws -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        if let result = formatter.date(from: dateString) {
            return result
        } else {
            throw Position.Error.failedParsingDate
        }
    }
    
}

/// Wrapper for education background.
struct Education: Decodable {
    var school: String
    var startedAt: Date
    var finishedAt: Date?
    var course: String
    
    enum Error: Swift.Error {
        case failedParsingDate
    }
    
    enum CodingKeys: String, CodingKey {
        case school
        case startedAt
        case finishedAt
        case course
    }
    
    init(school: String, startedAt: Date, finishedAt: Date?, course: String) {
        self.school = school
        self.startedAt = startedAt
        self.finishedAt = finishedAt
        self.course = course
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        school = try container.decode(String.self, forKey: .school)
        let startedAtString = try container.decode(String.self, forKey: .startedAt)
        startedAt = try Position.date(from: startedAtString)
        let finishedAtString = try container.decodeIfPresent(String.self, forKey: .finishedAt)
        finishedAt = finishedAtString != nil ? try Position.date(from: finishedAtString!) : nil
        course = try container.decode(String.self, forKey: .course)
    }
}
