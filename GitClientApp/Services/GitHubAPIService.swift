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
  func fetchUser(with login: String) -> Promise<GitHubUser>
  func fetchRepositories(for login: String) -> Promise<GitHubRepositories>
}

final class GitHubAPIV3Service: GitHubAPIService {
  
  func fetchUsers() -> Promise<GitHubUsers> {
    let request = GitHubUser.getGitHubUsers()
    return Session.requestWithPromise(request)
    
  }
  
  func fetchUser(with login: String) -> Promise<GitHubUser> {
    let request = GitHubUser.getGitHubUser(with: login)
    return Session.requestWithPromise(request)
  }
  
  func fetchRepositories(for login: String) -> Promise<GitHubRepositories> {
    return Promise<GitHubRepositories> { seal in
      seal.fulfill([])
    }
  }
}
