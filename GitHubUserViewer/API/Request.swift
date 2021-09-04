//
//  Request.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import Alamofire
import Foundation

protocol Request {
    associatedtype Response: Codable
    var method: HTTPMethod { get }
    var url: URL { get }
    var header: HTTPHeaders { get }
    var parameter: [String: Any] { get }
}

extension Request {
    // Default
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders {
        return HTTPHeaders(RequestHeader().header)
    }
}
