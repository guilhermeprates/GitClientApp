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
  
  func fetchGitHubUsers(_ completion: @escaping () -> () = {}) {
    isLoading = true
    apiService.fetchUsers().done { users in
      self.users = users
      self.errorMessage = nil
    }.catch { error in
      self.errorMessage = error.localizedDescription
    }.finally {
      self.isLoading = false
      completion()
    }
  }
  
  func fetchGitHubUser(with login: String, _ completion: @escaping () -> () = {}) {
    isLoading = true
    apiService.fetchUser(with: login).done { user in
      self.users = [ user ]
      self.errorMessage = nil
    }.catch { error in
      self.users = []
      self.errorMessage = error.localizedDescription
    }.finally {
      self.isLoading = false
      completion()
    }
  }
  
  // MARK: - Data Access
  
  func getUser(at index: Int) -> GitHubUser {
    return users[index]
  }
}
