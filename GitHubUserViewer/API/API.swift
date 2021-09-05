//
//  API.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/04.
//

import Alamofire
import Foundation

enum APIResult<T: Codable> {
    case success(_ result: T)
    case failure(_ error: APIError)
}

enum APIError: Error {
    case connection
    case parse
    case server(_ message: String)
    case unknown
    
    var message: String {
        switch self {
        case .connection: return R.string.localizable.error_connection()
        case .parse: return R.string.localizable.error_parse()
        case .server(let message): return message
        case .unknown: return R.string.localizable.error_unknown()
        }
    }
}

final class API {
    static func request<T: Request>(_ request: T, completion: @escaping (APIResult<T.Response>) -> Void) {
        AF.request(request.url,
                   method: request.method,
                   parameters: request.parameter,
                   headers: request.header)
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        completion(.failure(.unknown))
                        return
                    }
                    do {
                        let users = try JSONDecoder().decode(T.Response.self, from: data)
                        completion(.success(users))
                    } catch {
                        completion(.failure(.parse))
                    }
                case .failure:
                    completion(.failure(.connection))
                }
            }
    }
}
