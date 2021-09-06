//
//  UserDetailViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/05.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    private var viewModel: UserDetailViewModel?
    private let headerContentView = UserDetailHeaderView.instantiate()
    private var errorViewController = ErrorViewController.instantiate()
    private let headerHeight: CGFloat = 320.0
    private let estimatedRowHeight: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        viewModel?.delegate = self
        viewModel?.fetch()
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
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset.top = headerHeight
        tableView.backgroundColor = .clear
        errorViewController.action = { [weak self] in
            self?.viewModel?.fetch()
        }
    }
}

// MARK: - UITableViewDelegate
extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let repository = viewModel?.repositoryList[safe: indexPath.row] else { return }
        let webViewController = RepositoryWebViewController.instantiate(url: repository.repositoryURL)
        navigationController?.pushViewController(webViewController, animated: true)
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

// MARK: - UserDetailViewModelDelegate
extension UserDetailViewController: UserDetailViewModelDelegate {
    func userDetailViewModel(_ viewModel: UserDetailViewModel, didUpdate state: UserDetailViewModelState) {
        switch state {
        case .idle:
            tableView.isHidden = true
        case .loading:
            tableView.isHidden = true
            loadingView.startLoading()
        case .userDetailLoaded:
            loadingView.stopLoading()
            guard let detail = viewModel.userDetail else { return }
            headerContentView.setUserDetail(detail)
            headerContentView.setNeedsLayout()
        case .userDetailError:
            loadingView.stopLoading()
            guard let user = viewModel.user else { return }
            headerContentView.setMinimumData(user)
        case .repositoryListLoaded:
            loadingView.stopLoading()
            if viewModel.repositoryList.isEmpty {
                tableView.isHidden = true
                add(errorViewController, container: containerView)
                errorViewController.setMessssge(R.string.localizable.error_result_empty())
                errorViewController.retryButton.isHidden = true
            } else {
                remove(errorViewController)
                tableView.isHidden = false
                tableView.reloadData()
            }
        case .repositoryListError(message: let message):
            loadingView.stopLoading()
            tableView.isHidden = true
            add(errorViewController, container: containerView)
            errorViewController.setMessssge(message)
            errorViewController.retryButton.isHidden = false
        }
    }
}
