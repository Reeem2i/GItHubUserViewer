//
//  AppDelegate.swift
//  GitHubUserViewer
//
//  Created by Reimi Matsumoto on 2021/09/04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupView()
        return true
    }
    
    private func setupView() {
        let rootViewController = UIStoryboard(name: "RootViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: rootViewController.instantiateInitialViewController()!)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

