//
//  ViewControllerTests.swift
//  4HireTests
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import XCTest
@testable import _Hire

class ViewControllerTests: XCTestCase {

    var viewController: ViewController!
    
    override func setUp() {
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "MainVC") as? ViewController else { assert(false) }
        viewController = vc
        _ = viewController.view
    }
    
    func test_loadedViewController_hasCorrectContent() {
        // Given
        let rowsForEducation = CandidateViewModel.mock().education.count
        let rowsForExperience = CandidateViewModel.mock().experienceViewModels.count
        
        // When
        viewController.viewModel = CandidateViewModel.mock()
        
        // Then
        XCTAssertEqual(viewController.tableView.numberOfSections, 2)
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: Layout.Section.faculties.rawValue), rowsForEducation)
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: Layout.Section.experience.rawValue), rowsForExperience)
    }
}
