//
//  Array+Extension.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        if self.count > index {
            return self[index]
        } else {
            return nil
        }
    }
}
