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
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case firstName
        case lastName
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName
    }
}
