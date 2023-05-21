//
//  SceneDelegate.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    let viewModel = GitHubUserListViewModel()
    let rootViewController = GitHubUserListViewController(viewModel: viewModel)
    let navigationController = UINavigationController(rootViewController: rootViewController)
    
    window = UIWindow(frame: .zero)
    window?.makeKeyAndVisible()
    window?.rootViewController = navigationController
    window?.windowScene = windowScene
  }
}

