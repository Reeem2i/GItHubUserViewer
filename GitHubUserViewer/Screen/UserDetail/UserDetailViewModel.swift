//
//  UserDetailViewModel.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

enum UserDetailViewModelState {
    case idle, loading, userDetailLoaded, userDetailError(message: String?), repositoryListLoaded, repositoryListError(message: String?)
}

protocol UserDetailViewModelDelegate: AnyObject {
    func userDetailViewModel(_ viewModel: UserDetailViewModel, didUpdate state: UserDetailViewModelState)
}

final class UserDetailViewModel: ViewModel {
    typealias State = UserDetailViewModelState
    
    private(set) var state: UserDetailViewModelState = .idle {
        didSet {
            delegate?.userDetailViewModel(self, didUpdate: state)
        }
    }
    weak var delegate: UserDetailViewModelDelegate?
    private(set) var user: User?
    private(set) var userDetail: UserDetail?
    private(set) var repositoryList: [Repository] = []
    
    init(user: User) {
        self.user = user
    }
    
    func fetch() {
        fetchUserDetail()
        fetchRepositoryList()
    }
    
    private func fetchUserDetail() {
        guard let user = user else { return }
        state = .loading
        API.request(UserDetailRequest(user: user)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userDetail = data
                self.state = .userDetailLoaded
            case .failure(let error):
                self.state = .userDetailError(message: error.message)
            }
        }
    }
    
    private func fetchRepositoryList() {
        guard let user = user else { return }
        state = .loading
        API.request(RepositoryListRequest(user: user)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.repositoryList = data.filter { !$0.isFork }
                self.state = .repositoryListLoaded
            case .failure(let error):
                self.state = .repositoryListError(message: error.message)
            }
        }
    }
}
