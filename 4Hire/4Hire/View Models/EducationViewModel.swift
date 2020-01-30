//
//  EducationViewModel.swift
//  4Hire
//
//  Created by Filip Chwastowski on 29/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

struct EducationViewModel {
    private var education: Education
    
    init(education: Education) {
        self.education = education
    }
    
    var schoolName: String {
        get {
            education.school
        }
    }
    
    var facultyName: String {
        get {
            education.course
        }
    }
    
    /// Simplified description of faculty's dates range.
    var simplifiedDateRangeString: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM"
            let startedAt = formatter.string(from: education.startedAt)
            let finishedAt = education.finishedAt != nil ? formatter.string(from: education.finishedAt!) : "now"
            
            return "\(startedAt) - \(finishedAt)"
        }
    }
}
