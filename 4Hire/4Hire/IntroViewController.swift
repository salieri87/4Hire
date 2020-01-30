//
//  IntroViewController.swift
//  4Hire
//
//  Created by Filip Chwastowski on 30/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var avatarYContstraint: NSLayoutConstraint!

    private var fetcher = GithubAvatarFetcher()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarYContstraint.constant = view.bounds.height
        avatarView.layer.cornerRadius = avatarView.bounds.width / 2.0
        view.layoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        fetchAvatar()
    }
    
    func fetchAvatar() {
        spinner.startAnimating()
        fetcher.downloadAvatarData(of: "chwastek") { result in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                if case let .success(data) = result {
                    self.avatarView.image = UIImage(data: data)
                    self.slideInAvatar()
                } else {
                    print("failed fetching avatar")
                }
            }
        }
    }
    
    func slideInAvatar() {
        avatarYContstraint.constant = 0
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseInOut,
                       animations: {
            self.view.layoutSubviews()
        }) { (_) in
            self.nextButton.isHidden = false
        }
    }
}
