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
    
    private var fetcher = GithubAvatarFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        fetcher.downloadAvatarData(of: "chwastek") { (result) in
            if case let .success(data) = result {
                print("YAY")
                DispatchQueue.main.async {
                    self.avatarView.image = UIImage(data: data)
                }
            } else {
                print("failed fetching avatar")
            }
        }
    }
}
