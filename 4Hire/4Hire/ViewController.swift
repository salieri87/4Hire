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
            DispatchQueue.main.async {
                self.tableView.delegate = self.viewModel
                self.tableView.dataSource = self.viewModel
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "n/a"
        
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
    enum Section: Int {
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
        Layout.Section(rawValue: section)?.title
    }
}
