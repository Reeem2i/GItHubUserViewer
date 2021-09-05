//
//  RootViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/04.
//

import UIKit

final class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = R.storyboard.userListViewController.instantiateInitialViewController()!
        let navigationController = UINavigationController(rootViewController: viewController)
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
    }
}
