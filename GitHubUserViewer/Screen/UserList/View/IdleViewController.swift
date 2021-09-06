//
//  IdleViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/07.
//

import UIKit

final class IdleViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!
    var action: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    static func instantiate() -> IdleViewController {
        return R.storyboard.idleViewController.instantiateInitialViewController()!
    }
}

// MARK: - Private Functions
private extension IdleViewController {
    func setupSubviews() {
        imageView.image = R.image.icon_search_idle()
        imageView.tintColor = R.color.pale_primary()
        messageLabel.text = R.string.localizable.list_idle_message()
        messageLabel.font = .systemFont(ofSize: 14.0, weight: .thin)
        messageLabel.textColor = R.color.textSecondary()
    }
}
