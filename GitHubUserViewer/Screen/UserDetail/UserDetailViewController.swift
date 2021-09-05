//
//  UserDetailViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

enum UserDetailViewControllerState {
    case  idle, loading, loaded, error(message: String?)
}

class UserDetailViewController: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    private var state: UserDetailViewControllerState = .idle
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        fetchUserDetail()
    }
    
    static func instantieate(user: User) -> UserDetailViewController {
        let viewController = R.storyboard.userDetailViewController.instantiateInitialViewController()!
        viewController.user = user
        return viewController
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
    
    func fetchUserDetail() {
        guard let user = user else { return }
        API.request(UserDetailRequest(user: user)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.state = .loaded
                print(data)
            case .failure(let error):
                self.state = .error(message: error.message)
            }
        }
    }
}
