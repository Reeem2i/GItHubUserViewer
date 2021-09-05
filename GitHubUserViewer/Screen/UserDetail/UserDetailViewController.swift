//
//  UserDetailViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    static func instantieate() -> UserDetailViewController {
        return R.storyboard.userDetailViewController.instantiateInitialViewController()!
    }
}

private extension UserDetailViewController {
    func setupSubviews() {
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        userNameLabel.font = .systemFont(ofSize: 18.0)
        userFullNameLabel.font = .systemFont(ofSize: 14.0)
        followLabel.font = .systemFont(ofSize: 32.0)
        followerLabel.font = .systemFont(ofSize: 32.0)
        
        iconImageView.image = R.image.icon_user_noimage()
        userNameLabel.text = "SampleUser"
        userFullNameLabel.text = "User FullName"
        followLabel.text = "1288"
        followerLabel.text = "489"
    }
}
