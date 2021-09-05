//
//  RootViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/04.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var userList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

private extension RootViewController {
    func search(by word: String) {
        API().request(UserListRequest(searchWord: word)) { [weak self] result in
            switch result {
            case .success(let data):
                self?.userList = data.items
            case .failure:
                // TODO: エラー表示
                break
            }
        }
    }
    
    func showEmptyError() {
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        let alert = UIAlertController(title: "",
                                      message: "検索条件を入力してください",
                                      preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension RootViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            showEmptyError()
            return
        }
        search(by: searchText)
    }
}

extension RootViewController: UITableViewDelegate {
    
}

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
