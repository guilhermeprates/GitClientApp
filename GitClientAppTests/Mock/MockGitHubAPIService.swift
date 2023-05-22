//
//  MockGitHubAPIService.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation
import PromiseKit
import Alamofire

final class MockGitHubAPIService: GitHubAPIService {
  
  var mockGitHubUsersPromise: Promise<GitHubUsers>
  var mockGitHubUserPromise: Promise<GitHubUser>
  var mockGitHubRepositoriesPromise: Promise<GitHubRepositories>
    
  init(
    mockGitHubUsersPromise: Promise<GitHubUsers>,
    mockGitHubUserPromise: Promise<GitHubUser>,
    mockGitHubRepositoriesPromise: Promise<GitHubRepositories>
  ) {
    self.mockGitHubUsersPromise = mockGitHubUsersPromise
    self.mockGitHubUserPromise = mockGitHubUserPromise
    self.mockGitHubRepositoriesPromise = mockGitHubRepositoriesPromise
  }
  
  func fetchUsers() -> Promise<GitHubUsers> {
    return mockGitHubUsersPromise
  }
  
  func fetchUser(with login: String) -> Promise<GitHubUser> {
    return mockGitHubUserPromise
  }
  
  func fetchRepositories(for login: String) -> Promise<GitHubRepositories> {
    return mockGitHubRepositoriesPromise
  }
}
