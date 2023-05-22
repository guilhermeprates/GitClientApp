//
//  GitHubAPIService.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation
import PromiseKit
import Alamofire

protocol GitHubAPIService {
  func fetchUsers() -> Promise<GitHubUsers>
  func fetchUser(with login: String) -> GitHubUser
  func fetchRepositories(for login: String) -> GitHubRepositories
}

final class GitHubAPIV3Service: GitHubAPIService {
  
  func fetchUsers() -> Promise<GitHubUsers> {
    let request = GitHubUser.getGitHubUsers()
    return Session.requestWithPromise(request)
    
  }
  
  func fetchUser(with login: String) -> GitHubUser {
    return GitHubUser(id: 0, login: "", type: "", siteAdmin: false)
  }
  
  func fetchRepositories(for login: String) -> GitHubRepositories {
    return []
  }
}
