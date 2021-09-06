//
//  RepositoryListCell.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import UIKit

final class RepositoryListCell: UITableViewCell {
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var starImageView: UIImageView!
    @IBOutlet private weak var starCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    func setRepository(_ repository: Repository) {
        repositoryNameLabel.text = repository.name
        languageLabel.isHidden = repository.language == nil
        languageLabel.text = repository.language
        descriptionLabel.isHidden = repository.description == nil
        descriptionLabel.text = repository.description
        starCountLabel.text = String(repository.star)
    }
}

// MARK: - Private Functions
private extension RepositoryListCell {
    func setupSubviews() {
        repositoryNameLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        repositoryNameLabel.textColor = R.color.textPrimary()
        languageLabel.font = .systemFont(ofSize: 12.0, weight: .bold)
        languageLabel.textColor = R.color.textSecondary()
        descriptionLabel.font = .systemFont(ofSize: 12.0)
        descriptionLabel.textColor = R.color.textPrimary()
        starImageView.image = R.image.icon_star()
        starImageView.tintColor = R.color.yellow()
        starCountLabel.font = .systemFont(ofSize: 12.0)
        starCountLabel.textColor = R.color.textSecondary()
    }
}
