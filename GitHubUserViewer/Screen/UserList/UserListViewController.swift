//
//  UserListViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

enum UserListViewControllerState {
    case  idle, loading, loaded, error(message: String?)
}

final class UserListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    private var state: UserListViewControllerState = .idle {
        didSet {
            didChangeState(state)
        }
    }
    private var contentTableViewController = UserListContentViewController.instantiate()
    private var errorViewController = ErrorViewController.instantiate()
    private var searchText: String? {
        didSet {
            search(by: searchText)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    static func instantieate() -> UserListViewController {
        return R.storyboard.userListViewController.instantiateInitialViewController()!
    }
}

// MARK: - Private Functions
private extension UserListViewController {
    func setupSubviews() {
        loadingView.isHidden = true
        searchBar.delegate = self
        contentTableViewController.delegate = self
        errorViewController.action = { [weak self] in
            guard let self = self else { return }
            self.search(by: self.searchText)
        }
    }
    
    func add(_ viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func remove(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    func didChangeState(_ state: UserListViewControllerState) {
        switch state {
        case .idle:
            break
        case .loading:
            loadingView.isHidden = false
            loadingView.startAnimating()
        case .loaded:
            loadingView.isHidden = true
            loadingView.stopAnimating()
            add(contentTableViewController)
        case .error(let message):
            loadingView.isHidden = true
            loadingView.stopAnimating()
            add(errorViewController)
            errorViewController.setMessssge(message)
        }
    }
    
    func search(by word: String?) {
        guard let word = word, !word.isEmpty else {
            showEmptyError()
            return
        }
        state = .loading
        API().request(UserListRequest(searchWord: word)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.state = .loaded
                self.contentTableViewController.updateUserList(data.items)
            case .failure(let error):
                self.state = .error(message: error.message)
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

// MARK: - UISearchBarDelegate
extension UserListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text
    }
}

// MARK: - UserListContentViewControllerDelegate
extension UserListViewController: UserListContentViewControllerDelegate {
    func userListContentViewController(_ viewController: UserListContentViewController, didSelect user: User) {
        let viewController = UserDetailViewController.instantieate()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
