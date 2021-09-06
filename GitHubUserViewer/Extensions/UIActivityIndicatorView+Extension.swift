//
//  UIActivityIndicatorView+Extension.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import UIKit

extension UIActivityIndicatorView {
    func startLoading() {
        isHidden = false
        startAnimating()
    }
    
    func stopLoading() {
        isHidden = true
        stopAnimating()
    }
}
