//
//  UserListViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

final class UserListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var userList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.nib.userListCell.name, bundle: nil),
                           forCellReuseIdentifier: R.nib.userListCell.name)
    }
}

private extension UserListViewController {
    func search(by word: String) {
        API().request(UserListRequest(searchWord: word)) { [weak self] result in
            switch result {
            case .success(let data):
                self?.userList = data.items
                self?.tableView.reloadData()
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

extension UserListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            showEmptyError()
            return
        }
        search(by: searchText)
    }
}

extension UserListViewController: UITableViewDelegate {
    
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.userListCell.name, for: indexPath) as? UserListCell else { return UITableViewCell() }
        cell.setUser(userList[indexPath.row])
        return cell
    }
}
