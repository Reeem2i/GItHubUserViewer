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
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        userNameLabel.font = .systemFont(ofSize: 18.0)
        userNameLabel.textColor = R.color.textPrimary()
        userFullNameLabel.font = .systemFont(ofSize: 14.0)
        userFullNameLabel.textColor = R.color.textSecondary()
        followingCountLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        followingCountLabel.textColor = R.color.textPrimary()
        followingTitleLabel.text = R.string.localizable.user_following()
        followingTitleLabel.font = .systemFont(ofSize: 14.0)
        followingTitleLabel.textColor = R.color.textSecondary()
        followerCountLabel.font = .systemFont(ofSize: 32.0, weight: .bold)
        followerCountLabel.textColor = R.color.textPrimary()
        followerTitleLabel.text = R.string.localizable.user_follower()
        followerTitleLabel.font = .systemFont(ofSize: 14.0)
        followerTitleLabel.textColor = R.color.textSecondary()
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
