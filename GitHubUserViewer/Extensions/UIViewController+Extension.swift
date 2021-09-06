//
//  UIViewController+Extension.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import UIKit

extension UIViewController {
    func add(_ viewController: UIViewController, container: UIView?) {
        addChild(viewController)
        if let container = container {
            viewController.view.frame = CGRect(origin: .zero, size: container.frame.size)
            container.addSubview(viewController.view)
        } else {
            view.addSubview(viewController.view)
        }
        viewController.didMove(toParent: self)
    }
    
    func remove(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
