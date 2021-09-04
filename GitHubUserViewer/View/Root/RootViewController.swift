//
//  RootViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/04.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        API().request(UserListRequest())
        // Do any additional setup after loading the view.
    }
}
