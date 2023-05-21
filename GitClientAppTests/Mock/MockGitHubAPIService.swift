//
//  MockGitHubAPIService.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

final class MockGitHubAPIService: GitHubAPIService {
  
  func fetchUsers() -> GitHubUsers {
    return []
  }
  
  func fetchUser(with username: String) -> GitHubUser {
    return GitHubUser(id: 0, login: "", type: "", siteAdmin: false)
  }
  
  func fetchRepositories(for username: String) -> GitHubRepositories {
    return []
  }
}
