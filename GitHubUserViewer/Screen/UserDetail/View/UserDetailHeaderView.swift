//
//  UserDetailHeaderView.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import UIKit

final class UserDetailHeaderView: UIView {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userFullNameLabel: UILabel!
    @IBOutlet private weak var followingCountLabel: UILabel!
    @IBOutlet private weak var followingTitleLabel: UILabel!
    @IBOutlet private weak var followerCountLabel: UILabel!
    @IBOutlet private weak var followerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    static func instantiate() -> UserDetailHeaderView {
        return R.nib.userDetailHeaderView.firstView(owner: nil)!
    }
    
    func setUserDetail(_ userDetail: UserDetail) {
        iconImageView.fetchImage(url: userDetail.avatarUrl, defaultImage: R.image.icon_user_noimage())
        userNameLabel.text = userDetail.name
        userFullNameLabel.text = userDetail.fullName
        followingCountLabel.text = String(userDetail.following)
        followerCountLabel.text = String(userDetail.followers)
    }
    
    func setMinimumData(_ user: User) {
        iconImageView.fetchImage(url: user.avatarUrl, defaultImage: R.image.icon_user_noimage())
        userNameLabel.text = user.name
        userFullNameLabel.text = R.string.localizable.empty()
        followingCountLabel.text = R.string.localizable.empty()
        followerCountLabel.text = R.string.localizable.empty()
    }
}

// MARK: - Private Functions
private extension UserDetailHeaderView {
    func setupSubviews() {
        backgroundColor = R.color.primary()
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        userNameLabel.font = .systemFont(ofSize: 24.0, weight: .bold)
        userNameLabel.textColor = R.color.textOnPrimary()
        userFullNameLabel.font = .systemFont(ofSize: 14.0)
        userFullNameLabel.textColor = R.color.textOnPrimarySecond()
        followingCountLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        followingCountLabel.textColor = R.color.textOnPrimary()
        followingTitleLabel.text = R.string.localizable.user_following()
        followingTitleLabel.font = .systemFont(ofSize: 14.0)
        followingTitleLabel.textColor = R.color.textOnPrimarySecond()
        followerCountLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        followerCountLabel.textColor = R.color.textOnPrimary()
        followerTitleLabel.text = R.string.localizable.user_follower()
        followerTitleLabel.font = .systemFont(ofSize: 14.0)
        followerTitleLabel.textColor = R.color.textOnPrimarySecond()
    }
    
    func setPlaceholder() {
        iconImageView.image = R.image.icon_user_noimage()
        userNameLabel.text = R.string.localizable.empty()
        userFullNameLabel.text = R.string.localizable.empty()
        followingCountLabel.text = R.string.localizable.empty()
        followerCountLabel.text = R.string.localizable.empty()
    }
}
