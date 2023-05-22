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
  func fetchUsers() -> Promise<GitHubUsers> {
    return Promise<GitHubUsers> { seal in
      seal.fulfill([])
    }
  }
  
  func fetchUser(with login: String) -> GitHubUser {
    return GitHubUser(id: 0, login: "", type: "", siteAdmin: false)
  }
  
  func fetchRepositories(for login: String) -> GitHubRepositories {
    return []
  }
}
