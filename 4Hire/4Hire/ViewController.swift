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
            tableView.delegate = viewModel
            tableView.dataSource = viewModel
            DispatchQueue.main.async {
                self.navigationItem.title = self.viewModel?.name
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "n/a"
        tableView.rowHeight = 44.0
        fetchViewModel()
    }
    
    func fetchViewModel() {
        LocalNetworkingManager.sharedManager.downloadCandidate { (result) in
            if case let .success(response) = result {
                self.viewModel = CandidateViewModel(candidate: response)
            } else {
                self.viewModel = nil
            }
        }
    }
}

struct Layout {
    enum Section: Int, CaseIterable {
        case experience
        case faculties
        
        var title: String? {
            switch self {
            case .experience:
                return "Experience"
            case .faculties:
                return "Education"
            }
        }
    }
}

extension CandidateViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Layout.Section.experience.rawValue:
            return experienceViewModels.count
        case Layout.Section.faculties.rawValue:
            return education.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Layout.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case Layout.Section.experience.rawValue:
            let expCell = tableView.dequeueReusableCell(withIdentifier: "ExperienceCell", for: indexPath) as! ExperienceTableViewCell
                expCell.update(with: experienceViewModels[indexPath.row])
                return expCell
            case Layout.Section.faculties.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.textLabel?.text = "School"
                cell.detailTextLabel?.text = education[indexPath.row].school
                return cell
            default:
                return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Layout.Section(rawValue: section)?.title
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        44.0
    }
}
