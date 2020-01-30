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
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    
    func update(with experienceViewModel: ExperienceViewModel) {
        companyLogoView.image = image(for: experienceViewModel.companyName)
        roleLabel.text = experienceViewModel.roleName
        datesLabel.text = experienceViewModel.simplifiedDateRangeString
    }
    
    private func image(for companyName: String) -> UIImage? {
        switch companyName.lowercased() {
        case "prophone":
            return #imageLiteral(resourceName: "prophone")
        case "webspirit":
            return #imageLiteral(resourceName: "webspirit")
        case "estimote":
            return #imageLiteral(resourceName: "estimote")
        default:
            return nil
        }
    }
}

