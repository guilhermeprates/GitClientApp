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
  
  private var users: GitHubUsers = []
  
  private(set) var isLoading: Bool = false
  
  private(set) var errorMessage: String?
  
  var numberOfUsers: Int {
    return users.count
  }
  
  // MARK: - Initialization
  
  init(apiService: GitHubAPIService = GitHubAPIV3Service()) {
    self.apiService = apiService
  }
  
  // MARK: - API Call
  
  func fetchGitHubUsers() {
    isLoading = true
    apiService.fetchUsers().done { users in
      dump(users)
      self.users = users
    }.catch { error in
      dump(error)
      self.errorMessage = error.localizedDescription
    }.finally {
      self.isLoading = false
    }
  }
  
  func fetchGitHubUser(with login: String) {
    isLoading = true
    apiService.fetchUser(with: login).done { user in
      dump(user)
      self.users = [ user ]
    }.catch { error in
      dump(error)
      self.errorMessage = error.localizedDescription
    }.finally {
      self.isLoading = false
    }
  }
  
  // MARK: - Data Access
  
  func getUser(at index: Int) -> GitHubUser {
    return users[index]
  }
}
