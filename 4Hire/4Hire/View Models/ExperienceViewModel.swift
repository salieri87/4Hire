//
//  ExperienceViewModel.swift
//  4Hire
//
//  Created by Filip Chwastowski on 28/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

struct ExperienceViewModel {
    /// Simple summary of role's details.
    var shortDescription: String {
        get { "\(position.name) @ \(position.company)" }
    }
    
    private var position: Position
    
    init(position: Position) {
        self.position = position
    }
    
    
}
