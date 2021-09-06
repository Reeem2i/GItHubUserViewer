//
//  ErrorViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

final class ErrorViewController: UIViewController {
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    var action: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    static func instantiate() -> ErrorViewController {
        return R.storyboard.errorViewController.instantiateInitialViewController()!
    }
    
    @IBAction func didTapRetryButton(_ sender: Any) {
        action?()
    }
    
    func setMessssge(_ message: String?) {
        messageLabel.text = message
    }
}

// MARK: - Private Functions
private extension ErrorViewController {
    func setupSubviews() {
        messageLabel.text = R.string.localizable.error_unknown()
        messageLabel.font = .systemFont(ofSize: 14.0, weight: .thin)
        messageLabel.textColor = R.color.textSecondary()
        retryButton.setTitle(R.string.localizable.retry(), for: .normal)
        retryButton.layer.cornerRadius = retryButton.frame.height / 2
        retryButton.backgroundColor = R.color.primary()
        retryButton.setTitleColor(R.color.textOnPrimary(), for: .normal)
    }
}
