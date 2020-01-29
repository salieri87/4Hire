//
//  ExperienceTableViewCell.swift
//  4Hire
//
//  Created by Filip Chwastowski on 29/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyLogoView: UIImageView!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    
    func update(with experienceViewModel: ExperienceViewModel) {
        companyLogoView.image = #imageLiteral(resourceName: "jobIcon")
        shortDescriptionLabel.text = experienceViewModel.shortDescription
    }
    
}
