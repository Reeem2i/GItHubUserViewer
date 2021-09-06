//
//  URLDefine.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/07.
//

import Foundation

struct URLDefine {
    static let baseURL = URL(string: "https://api.github.com/")!
    
    enum Path: String {
        case search = "search/users"
        case users = "users/"
    }
    
    static func makeURL(path: Path) -> URL {
        return baseURL.appendingPathComponent(path.rawValue)
    }
}
