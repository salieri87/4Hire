//
//  CandidateViewModel.swift
//  4Hire
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class CandidateViewModel: NSObject {
    private var candidate: Candidate

    /// Candidate's full name.
    var name: String {
        candidate.firstName + " " + candidate.lastName
    }

    /// Candidate's list of past and current employments.
    var experience: [Position] {
        candidate.experience ?? [Position]()
    }

    /// Candidate's list of past and current faculties.
    var education: [Education] {
        candidate.education ?? [Education]()
    }

    required init(candidate: Candidate) {
        self.candidate = candidate
    }

    // MARK: - Debuging

    static func mock() -> Self {
        let experience = [Position(name: "junior",
                                   company: "Somewhere",
                                   startedAt: Date.distantPast,
                                   finishedAt: nil,
                                   jobDescription: "just being junior")]
        let education = [Education(school: "AGH",
                                   startedAt: Date.distantPast,
                                   finishedAt: nil,
                                   course: "Computer Science")]

        return Self(candidate: Candidate(identifier: 1,
                                         firstName: "John",
                                         lastName: "Appleseed",
                                         experience: experience,
                                         education: education))
    }
}
