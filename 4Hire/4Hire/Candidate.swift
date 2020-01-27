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
}

/// Wrapper for education background.
struct Education: Decodable {
    var school: String
    var startedAt: String
    var finishedAt: String?
    var course: String
}
