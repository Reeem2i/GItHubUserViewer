//
//  UserListViewModel.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import Foundation

enum UserListViewModelState {
    case idle, loading, loaded, loadedAdditional, error(message: String?)
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
    private(set) var isContinuous: Bool = false
    private var currentPage: Int = 1
    private var currentWord: String = ""
    
    func search(by word: String) {
        state = .loading
        currentPage = 1
        currentWord = word
        API.request(UserListRequest(searchWord: word)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userList = data.items
                self.isContinuous = data.count > data.items.count
                self.state = .loaded
            case .failure(let error):
                self.state = .error(message: error.message)
            }
        }
    }
    
    func fetchAdditionalUser() {
        currentPage += 1
        API.request(UserListRequest(searchWord: currentWord, page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userList += data.items
                self.isContinuous = data.count > data.items.count
                self.state = .loadedAdditional
            case .failure:
                break
            }
        }
    }
    
    func clearResult() {
        userList = []
        currentPage = 1
        currentWord = ""
        state = .idle
    }
}
