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
    var url: URL = URLDefine.makeURL(path: .users)
    var parameter: [String : Any] = [:]
    
    init(user: User) {
        url = URL(string: url.absoluteString + user.name + "/repos") ?? url
    }
}
