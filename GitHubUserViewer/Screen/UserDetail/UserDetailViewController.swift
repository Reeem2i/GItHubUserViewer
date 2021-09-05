//
//  UserDetailViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userFullNameLabel: UILabel!
    @IBOutlet private weak var followLabel: UILabel!
    @IBOutlet private weak var followerLabel: UILabel!
    
    private var viewModel: UserDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        viewModel?.delegate = self
        viewModel?.fetchUserDetail()
    }
    
    static func instantieate(user: User) -> UserDetailViewController {
        let viewController = R.storyboard.userDetailViewController.instantiateInitialViewController()!
        viewController.viewModel = UserDetailViewModel(user: user)
        return viewController
    }
}

// MARK: - Private Functions
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

// MARK: - UserDetailViewModelDelegate
extension UserDetailViewController: UserDetailViewModelDelegate {
    func userDetailViewModel(_ viewModel: UserDetailViewModel, didUpdate state: UserDetailViewModelState) {
        // TODO
    }
}
