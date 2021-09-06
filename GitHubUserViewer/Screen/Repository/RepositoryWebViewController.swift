//
//  RepositoryWebViewController.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/06.
//

import UIKit
import WebKit

final class RepositoryWebViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    @IBOutlet private weak var nextButton: UIBarButtonItem!
    @IBOutlet private weak var refleshButton: UIBarButtonItem!
    
    private var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.backgroundColor = R.color.background()
        loadingView.isHidden = true
        backButton.isEnabled = false
        nextButton.isEnabled = false
        refleshButton.isEnabled = false
        load()
    }
    
    static func instantiate(url: URL) -> RepositoryWebViewController {
        let viewController = R.storyboard.repositoryWebViewController.instantiateInitialViewController()!
        viewController.url = url
        return viewController
    }
}

// MARK: - Private Functions
extension RepositoryWebViewController {
    func load() {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @IBAction func didTapBackButton(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func didTapNextButton(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func didTapRefleshButton(_ sender: UIBarButtonItem) {
        webView.reload()
    }
}

// MARK: - WKNavigationDelegate
extension RepositoryWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loadingView.stopLoading()
            self.backButton.isEnabled = webView.canGoBack
            self.nextButton.isEnabled = webView.canGoForward
            self.refleshButton.isEnabled = self.loadingView.isHidden
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loadingView.startLoading()
            self.refleshButton.isEnabled = self.loadingView.isHidden
        }
    }
}
