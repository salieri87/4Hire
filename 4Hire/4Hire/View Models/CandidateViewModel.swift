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

    /// View models collection of past and current employments.
    var experienceViewModels: [ExperienceViewModel] {
        candidate.experience?.map{ ExperienceViewModel(position: $0) } ?? [ExperienceViewModel]()
    }

    /// View models of candidate's past and current faculties.
    var educationViewModels: [EducationViewModel] {
        candidate.education?.map{ EducationViewModel(education: $0) } ?? [EducationViewModel]()
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
