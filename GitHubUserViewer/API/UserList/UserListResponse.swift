//
//  UserListResponse.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

/// 条件に合うユーザーの一覧を取得する
/// API Document: https://docs.github.com/ja/rest/reference/search#search-users
struct UserListResponse: Codable {
    let count: Int
    let items: [User]
    
    enum CodingKeys: String, CodingKey {
        case count = "total_count"
        case items
    }
}
