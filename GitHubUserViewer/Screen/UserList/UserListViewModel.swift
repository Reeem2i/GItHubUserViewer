//
//  UserListViewModel.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import Foundation

enum UserListViewModelState {
    case idle, loading, loaded, error(message: String?)
}

protocol UserListViewModelDelegate: AnyObject {
    func userListViewModel(_ viewModel: UserListViewModel, didUpdate state: UserListViewModelState)
}

final class UserListViewModel: ViewModel {
    typealias State = UserListViewModelState
    
    private(set) var state: UserListViewModelState = .idle {
        didSet {
            delegate?.userListViewModel(self, didUpdate: state)
        }
    }
    weak var delegate: UserListViewModelDelegate?
    private(set) var userList: [User] = []
    
    func search(by word: String) {
        state = .loading
        API.request(UserListRequest(searchWord: word)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userList = data.items
                self.state = .loaded
            case .failure(let error):
                self.state = .error(message: error.message)
            }
        }
    }
    
    func clearResult() {
        userList = []
        state = .idle
    }
}
