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
    
    var name: String {
        get {
            candidate.firstName + " " + candidate.lastName
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
