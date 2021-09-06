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
    func didScrollToBottom(_ viewController: UserListContentViewController)
}

final class UserListContentViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: UserListContentViewControllerDelegate?
    private(set) var userList: [User] = []
    private(set) var isContinuous: Bool = false
    private let estimatedRowHeight: CGFloat = 68.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    static func instantiate() -> UserListContentViewController {
        return R.storyboard.userListContentViewController.instantiateInitialViewController()!
    }
    
    func updateUserList(_ list: [User], isContinuous: Bool) {
        userList = list
        self.isContinuous = isContinuous
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
        tableView.register(UINib(nibName: R.nib.indicatorCell.name, bundle: nil),
                           forCellReuseIdentifier: R.nib.indicatorCell.name)
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
        return isContinuous ? userList.count + 1 : userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if userList.count == indexPath.row {
            guard let indicatorCell = tableView.dequeueReusableCell(withIdentifier: R.nib.indicatorCell.name, for: indexPath) as? IndicatorCell else { return cell }
            indicatorCell.loadingView.startAnimating()
            cell = indicatorCell
        } else {
            guard let listCell = tableView.dequeueReusableCell(withIdentifier: R.nib.userListCell.name, for: indexPath) as? UserListCell,
                  let user = userList[safe: indexPath.row] else { return cell }
            listCell.setUser(user)
            cell = listCell
        }
        return cell
    }
}

// MARK: - UserListContentViewController
extension UserListContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScrollList(self)
        if (tableView.contentOffset.y + tableView.frame.size.height > tableView.contentSize.height
                && tableView.isDragging && isContinuous) {
            delegate?.didScrollToBottom(self)
        }
    }
}
