//
//  API.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/04.
//

import Alamofire
import Foundation

final class API {
    func request<T: Request>(_ request: T) {
        // TODO: エラーハンドリング
        AF.request(request.url,
                   method: request.method,
                   parameters: request.parameter,
                   headers: request.header)
            .responseJSON { response in
                guard let data = response.data else {
                    print("failure")
                    return
                }
                do {
                    print(String(data: data, encoding: .utf8)!)
                    let users = try JSONDecoder().decode(T.Response.self, from: data)
                    print(users)
                } catch {
                    print("failure")
                }
            }
    }
}
