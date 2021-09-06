//
//  UserDetailRequest.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import Foundation

/// ユーザー情報を取得する
/// API Document: https://docs.github.com/ja/rest/reference/users#get-a-user
final class UserDetailRequest: Request {
    typealias Response = UserDetail
    var url: URL = URLDefine.makeURL(path: .users)
    var parameter: [String : Any] = [:]
    
    init(user: User) {
        url = url.appendingPathComponent(user.name)
    }
}
