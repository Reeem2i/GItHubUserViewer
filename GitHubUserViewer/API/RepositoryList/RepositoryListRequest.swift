//
//  RepositoryListRequest.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import Foundation

/// ユーザー情報を取得する
/// API Document: https://docs.github.com/ja/rest/reference/repos#list-repositories-for-a-user
final class RepositoryListRequest: Request {
    typealias Response = [Repository]
    // TODO: URLの定義方法を修正する
    var url: URL = URL(string: "https://api.github.com/users/")!
    var parameter: [String : Any] = [:]
    
    init(user: User) {
        url = URL(string: url.absoluteString + user.name + "/repos") ?? url
    }
}
