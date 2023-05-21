//
//  GitHubAPIService.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

protocol GitHubAPIService {
  func fetchUsers() -> GitHubUsers
  func fetchUser(with username: String) -> GitHubUser
  func fetchRepositories(for username: String) -> GitHubRepositories
}

final class GitHubAPIV3Service: GitHubAPIService {
  
  func fetchUsers() -> GitHubUsers {
    return []
  }
  
  func fetchUser(with name: String) -> GitHubUser {
    return GitHubUser(id: 0, login: "", type: "", siteAdmin: false)
  }
  
  func fetchRepositories(for username: String) -> GitHubRepositories {
    return []
  }
}
