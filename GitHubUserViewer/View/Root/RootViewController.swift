//
//  RootViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/04.
//

import UIKit

class RootViewController: UIViewController {

    private var userList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API().request(UserListRequest()) { [weak self] result in
            switch result {
            case .success(let data):
                self?.userList = data.items
            case .failure:
                // TODO: エラー表示
                break
            }
        }
    }
}
    }
}
