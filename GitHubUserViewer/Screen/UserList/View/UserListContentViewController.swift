//
//  UserListContentViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

protocol UserListContentViewControllerDelegate: AnyObject {
    func userListContentViewController(_ viewController: UserListContentViewController, didSelect user: User)
    func didScrollList(_ viewController: UserListContentViewController)
}

final class UserListContentViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: UserListContentViewControllerDelegate?
    private(set) var userList: [User] = []
    private let estimatedRowHeight: CGFloat = 68.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    static func instantiate() -> UserListContentViewController {
        return R.storyboard.userListContentViewController.instantiateInitialViewController()!
    }
    
    func updateUserList(_ list: [User]) {
        userList = list
        tableView.reloadData()
    }
}

// MARK: - Private Function
private extension UserListContentViewController {
    func setupSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.nib.userListCell.name, bundle: nil),
                           forCellReuseIdentifier: R.nib.userListCell.name)
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDelegate
extension UserListContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let user = userList[safe: indexPath.row] else { return }
        delegate?.userListContentViewController(self, didSelect: user)
    }
}

// MARK: - UITableViewDataSource
extension UserListContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.userListCell.name, for: indexPath) as? UserListCell,
              let user = userList[safe: indexPath.row] else { return UITableViewCell() }
        cell.setUser(user)
        return cell
    }
}

// MARK: - UserListContentViewController
extension UserListContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScrollList(self)
    }
}
