//
//  ViewController.swift
//  4Hire
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = CandidateViewModel.mock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.name
    }
}
