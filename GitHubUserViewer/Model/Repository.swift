//
//  Repository.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import Foundation

struct Repository: Codable {
    let name: String
    let isFork: Bool
    let language: String?
    let star: Int
    let description: String?
    let repositoryURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case isFork = "fork"
        case language
        case star = "stargazers_count"
        case description
        case repositoryURL = "html_url"
    }
}
