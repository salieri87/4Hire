//
//  EducationTableViewCell.swift
//  4Hire
//
//  Created by Filip Chwastowski on 29/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {

    func update(with viewModel: EducationViewModel) {
        textLabel?.text = viewModel.schoolName
        detailTextLabel?.text = viewModel.facultyName + ", " + viewModel.simplifiedDateRangeString
    }
}
