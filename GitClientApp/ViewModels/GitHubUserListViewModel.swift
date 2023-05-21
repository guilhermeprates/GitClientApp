//
//  GitHubUserListViewModel.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

final class GitHubUserListViewModel {
  
  // MARK: - Properties
  
  private var apiService: GitHubAPIService
  
  // MARK: - Initialization
  
  init(apiService: GitHubAPIService = GitHubAPIV3Service()) {
    self.apiService = apiService
  }
}
