//
//  UserDetailViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: UserDetailViewModel?
    private let headerContentView = UserDetailHeaderView.instantiate()
    private let headerHeight: CGFloat = 320.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        viewModel?.delegate = self
        viewModel?.fetchUserDetail()
        viewModel?.fetchRepositoryList()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    static func instantieate(user: User) -> UserDetailViewController {
        let viewController = R.storyboard.userDetailViewController.instantiateInitialViewController()!
        viewController.viewModel = UserDetailViewModel(user: user)
        return viewController
    }
}

// MARK: - Private Functions
private extension UserDetailViewController {
    func setupSubviews() {
        headerView.addSubview(headerContentView)
        tableView.register(UINib(nibName: R.nib.repositoryListCell.name, bundle: nil),
                           forCellReuseIdentifier: R.nib.repositoryListCell.name)
        tableView.contentInset.top = headerHeight
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableViewDelegate
extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let repository = viewModel?.repositoryList[safe: indexPath.row] else { return }
        // TODO: Webviewを表示
    }
}

// MARK: - UITableViewDataSource
extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repositoryList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.repositoryListCell.name, for: indexPath) as? RepositoryListCell,
              let repository = viewModel?.repositoryList[safe: indexPath.row] else { return UITableViewCell() }
        cell.setRepository(repository)
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension UserDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

// MARK: - UserDetailViewModelDelegate
extension UserDetailViewController: UserDetailViewModelDelegate {
    func userDetailViewModel(_ viewModel: UserDetailViewModel, didUpdate state: UserDetailViewModelState) {
        switch state {
        case .idle:
            break
        case .loading:
            break
        case .userDetailLoaded:
            guard let detail = viewModel.userDetail else { return }
            headerContentView.setUserDetail(detail)
            headerContentView.setNeedsLayout()
        case .userDetailError(message: let message):
            break
        case .repositoryListLoaded:
            tableView.reloadData()
        case .repositoryListError(message: let message):
            break
        }
    }
}
