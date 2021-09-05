//
//  UserDetail.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import Foundation

struct UserDetail: Codable {
    let name: String
    let fullName: String
    let avatarUrl: URL
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case fullName = "name"
        case avatarUrl = "avatar_url"
        case followers
        case following
    }
}
