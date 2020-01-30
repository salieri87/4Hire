//
//  ResumeViewController.swift
//  4Hire
//
//  Created by Filip Chwastowski on 27/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class ResumeViewController: UIViewController {
    var viewModel: CandidateViewModel? {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            DispatchQueue.main.async {
                self.navigationItem.title = self.viewModel?.name
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    var shouldExpandCells: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(self.toggleTableExpansion), imageName: self.shouldExpandCells ? "shrink" : "expand")
                if self.shouldExpandCells != oldValue {
                    self.tableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableView.RowAnimation.top)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        let button = UIBarButtonItem.menuButton(self, action: #selector(toggleTableExpansion), imageName: "expand")
        navigationItem.setRightBarButton(button, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = nil
        tableView.rowHeight = 44.0
        fetchViewModel()
    }
    
    func fetchViewModel() {
        LocalCandidateFetcher.sharedManager.downloadCandidate { (result) in
            if case let .success(response) = result {
                self.viewModel = CandidateViewModel(candidate: response)
            } else {
                let alert = UIAlertController(title: "Error", message: "Loading candidate's data failed.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func toggleTableExpansion() {
        shouldExpandCells.toggle()
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

extension ResumeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Layout.Section.experience.rawValue:
            return viewModel?.experienceViewModels.count ?? 0
        case Layout.Section.faculties.rawValue:
            return viewModel?.educationViewModels.count ?? 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Layout.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        assert(viewModel != nil, "Should not reload cell, if no data available!")
        
        switch indexPath.section {
            case Layout.Section.experience.rawValue:
                let expCell = tableView.dequeueReusableCell(withIdentifier: shouldExpandCells ? "ExpandedExperienceCell" : "ExperienceCell", for: indexPath) as! ExperienceTableViewCell
                expCell.update(with: viewModel!.experienceViewModels[indexPath.row], isExpanded: shouldExpandCells)
                return expCell
            case Layout.Section.faculties.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "EducationCell", for: indexPath) as! EducationTableViewCell
                cell.update(with: viewModel!.educationViewModels[indexPath.row])
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        shouldExpandCells ? UITableView.automaticDimension : 44.0
    }
}

extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return menuBarItem
    }
}
