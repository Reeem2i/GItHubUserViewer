//
//  UserListResponse.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

struct UserListResponse: Codable {
    let count: Int
    let items: [User]
    
    enum CodingKeys: String, CodingKey {
        case count = "total_count"
        case items
    }
}
