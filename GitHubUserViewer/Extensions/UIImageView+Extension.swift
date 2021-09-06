//
//  UIImageView+Extension.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import UIKit

extension UIImageView {
    func fetchImage(url: URL, defaultImage: UIImage?) {
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            self.image = image
        } catch {
            self.image = defaultImage
        }
    }
}
