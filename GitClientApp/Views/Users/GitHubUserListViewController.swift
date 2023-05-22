//
//  GitHubUserListViewController.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import UIKit

class GitHubUserListViewController: BaseViewController {
  
  private let viewModel: GitHubUserListViewModel
  
  init(viewModel: GitHubUserListViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  // MARK: View life cycle
  
  override func viewDidLoad() {
    title = "GitHub Users"
    
    viewModel.fetchGitHubUsers()
  }
}
