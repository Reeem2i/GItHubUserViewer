//
//  UserDetailViewModel.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

enum UserDetailViewModelState {
    case idle, loading, loaded, error(message: String?)
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
    
    init(user: User) {
        self.user = user
    }
    
    func fetchUserDetail() {
        guard let user = user else { return }
        API.request(UserDetailRequest(user: user)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userDetail = data
                self.state = .loaded
            case .failure(let error):
                self.state = .error(message: error.message)
            }
        }
    }
}
