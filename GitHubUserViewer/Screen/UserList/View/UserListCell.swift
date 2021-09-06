//
//  UserListCell.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

final class UserListCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    func setUser(_ user: User) {
        iconImageView.fetchImage(url: user.avatarUrl, defaultImage: R.image.icon_user_noimage())
        userNameLabel.text = user.name
    }
}

// MARK: - Private Functions
private extension UserListCell {
    func setupSubviews() {
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        userNameLabel.font = .systemFont(ofSize: 14.0)
    }
}
