//
//  Mocks.swift
//  4HireTests
//
//  Created by Filip Chwastowski on 28/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
@testable import _Hire

struct Mocks {
    /// Returns stubbed `Candidate` model based on test file content.
    static func stubModel() -> Candidate {
        return Candidate(identifier: 100,
                         firstName: "David",
                         lastName: "von Test",
                         experience: nil,
                         education: nil)
    }
}
