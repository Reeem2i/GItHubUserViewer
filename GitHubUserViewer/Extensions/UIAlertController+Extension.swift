//
//  UIAlertController+Extension.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import UIKit

extension UIAlertController {
    static func okAlert(title: String = "", message: String, action: ((UIAlertAction) -> Void)?) -> UIAlertController {
        UIAlertController(title: title,
                          message: message,
                          preferredStyle: .alert)
            .add(.init(title: R.string.localizable.ok(), style: .default, handler: action))
    }
    
    func add(_ action: UIAlertAction) -> UIAlertController {
        addAction(action)
        return self
    }
    
    func show(from viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: true, completion: completion)
    }
}
