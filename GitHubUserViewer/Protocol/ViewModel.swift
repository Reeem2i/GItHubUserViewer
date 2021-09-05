//
//  ViewModel.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

protocol ViewModel {
    associatedtype State
    associatedtype Delegate
    var state: State { get }
    var delegate: Delegate? { get set }
}
