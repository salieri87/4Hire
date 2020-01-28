//
//  ViewController.swift
//  4Hire
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: CandidateViewModel? {
        didSet {
            navigationItem.title = viewModel?.name
            tableView.delegate = viewModel
            tableView.dataSource = viewModel
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "n/a"
        
        CandidateViewModelFactory.getViewModel { (viewModel) in
            self.viewModel = viewModel
        }
    }
}

struct Layout {
    enum Section: Int {
        case experience
        case faculties
    }
}

extension CandidateViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Layout.Section.experience.rawValue:
            return experience.count
        case Layout.Section.faculties.rawValue:
            return education.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.section {
            case Layout.Section.experience.rawValue:
                cell.textLabel?.text = "Position"
                cell.detailTextLabel?.text = experience[indexPath.row].name
            case Layout.Section.faculties.rawValue:
                cell.textLabel?.text = "School"
                cell.detailTextLabel?.text = education[indexPath.row].school
            default:
                assert(false)
            }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Layout.Section.experience.rawValue:
            return "Experience"
        case Layout.Section.faculties.rawValue:
            return "Education"
        default:
            return nil
        }
    }
}
