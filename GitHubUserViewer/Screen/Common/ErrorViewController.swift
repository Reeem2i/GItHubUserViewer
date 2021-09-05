//
//  ErrorViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

final class ErrorViewController: UIViewController {
    @IBOutlet private weak var errorMessageLabel: UILabel!
    @IBOutlet private weak var retryButton: UIButton!
    var action: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    static func instantiate() -> ErrorViewController {
        let viewController = R.storyboard.errorViewController.instantiateInitialViewController()!
        return viewController
    }
    
    @IBAction func didTapRetryButton(_ sender: Any) {
        action?()
    }
    
    func setMessssge(_ message: String?) {
        errorMessageLabel.text = message
    }
}

// MARK: - Private Functions
private extension ErrorViewController {
    func setupSubviews() {
        retryButton.setTitle("再読み込み", for: .normal)
        retryButton.layer.cornerRadius = retryButton.frame.height / 2
    }
}
