//
//  CandidateViewModel.swift
//  4Hire
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

struct CandidateViewModel {
    private var candidate: Candidate
    
    /// Candidate's full name.
    var name: String {
        get {
            candidate.firstName + " " + candidate.lastName
        }
    }

    /// Candidate's list of past and current employments.
    var experience: [Position] {
        get {
            candidate.experience ?? [Position]()
        }
    }

    /// Candidate's list of past and current faculties.
    var education: [Education] {
        get {
            candidate.education ?? [Education]()
        }
    }
    
    init(candidate: Candidate) {
        self.candidate = candidate
    }
    
    // MARK: - Debuging
    static func mock() -> Self {
        Self(candidate: Candidate(identifier: 1, firstName: "John", lastName: "Appleseed", experience: nil, education: nil))
    }
}
