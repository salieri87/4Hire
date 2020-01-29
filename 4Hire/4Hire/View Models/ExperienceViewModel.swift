//
//  ExperienceViewModel.swift
//  4Hire
//
//  Created by Filip Chwastowski on 28/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

struct ExperienceViewModel {
    
    var roleName: String {
        get {
            position.name
        }
    }
    
    var companyName: String {
        get {
            position.company
        }
    }
    
    var roleDescription: String {
        position.jobDescription
    }
    
    /// Simplified description of position's dates range.
    var simplifiedDateRangeString: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM"
            let startedAt = formatter.string(from: position.startedAt)
            let finishedAt = position.finishedAt != nil ? formatter.string(from: position.finishedAt!) : "now"
            
            return "\(startedAt) - \(finishedAt)"
        }
    }
    
    private var position: Position
    
    init(position: Position) {
        self.position = position
    }
}
