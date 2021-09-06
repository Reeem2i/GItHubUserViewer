//
//  UserListRequest.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import Foundation

final class UserListRequest: Request {
    typealias Response = UserListResponse
    var url: URL = URLDefine.makeURL(path: .search)
    var parameter: [String : Any] {
        var parameter: [String: Any] = [:]
        parameter["q"] = searchWord
        parameter["page"] = page
        return parameter
    }
    
    let searchWord: String
    let page: Int
    
    init(searchWord: String, page: Int = 1) {
        self.searchWord = searchWord
        self.page = page
    }
}
