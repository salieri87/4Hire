//
//  IntroViewController.swift
//  4Hire
//
//  Created by Filip Chwastowski on 30/01/2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var spinner: UIActivityIndicatorView!

    private var fetcher = GithubAvatarFetcher()

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
                    print("YAY")
                    self.avatarView.image = UIImage(data: data)
                } else {
                    print("failed fetching avatar")
                }
            }
        }
    }
}
