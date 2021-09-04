//
//  RequestHeader.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

struct RequestHeader {
    var header: [String: String] {
        var header: [String: String] = [:]
        header["Authorization"] = "token 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"
        return header
    }
}
