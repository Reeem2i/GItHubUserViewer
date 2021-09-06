//
//  RepositoryListCell.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import UIKit

final class RepositoryListCell: UITableViewCell {
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    func setRepository(_ repository: Repository) {
        repositoryNameLabel.text = repository.name
    }
}

// MARK: - Private Functions
private extension RepositoryListCell {
    func setupSubviews() {
        
    }
}
