//
//  UserListRequest.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import Foundation

final class UserListRequest: Request {
    typealias Response = UserListResponse
    // TODO: URLの定義方法を修正する
    var url: URL = URL(string: "https://api.github.com/search/users")!
    var parameter: [String : Any] {
        var parameter: [String: Any] = [:]
        parameter["q"] = searchWord
        return parameter
    }
    
    let searchWord: String
    
    init(searchWord: String) {
        self.searchWord = searchWord
    }
}
