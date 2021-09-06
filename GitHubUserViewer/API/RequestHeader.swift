//
//  RequestHeader.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import Foundation

struct RequestHeader {
    var header: [String: String] {
        var header: [String: String] = [:]
        header["Authorization"] = String(format: "token %@", getToken())
        return header
    }
    
    func getToken() -> String {
        guard let fileURL = Bundle.main.url(forResource: "access_token", withExtension: "txt")  else {
            fatalError("access_token.txt not found")
        }
        guard let fileContents = try? String(contentsOf: fileURL) else {
            fatalError("could not read access_token.txt")
        }
        return fileContents
    }
}
