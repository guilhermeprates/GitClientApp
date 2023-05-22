//
//  GitHubUserListViewModel.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

protocol GitHubUserListViewModelDelegate: AnyObject {
  func didUpdateUserList()
  func didUpdateLoadingStatus()
  func didUpdateErrorMessage()
}

final class GitHubUserListViewModel {
  
  // MARK: - Properties
  
  private var apiService: GitHubAPIService
  
  private var users: GitHubUsers = [] {
    didSet {
      delegate?.didUpdateUserList()
    }
  }
  
  private(set) var isLoading: Bool = false {
    didSet {
      delegate?.didUpdateLoadingStatus()
    }
  }
  
  private(set) var errorMessage: String? {
    didSet {
      delegate?.didUpdateErrorMessage()
    }
  }
  
  var numberOfUsers: Int {
    return users.count
  }
  
  weak var delegate: GitHubUserListViewModelDelegate?
  
  // MARK: - Initialization
  
  init(apiService: GitHubAPIService = GitHubAPIV3Service()) {
    self.apiService = apiService
  }
  
  // MARK: - API Call
  
  func fetchGitHubUsers() {
    isLoading = true
    apiService.fetchUsers().done { users in
      self.users = users
      self.errorMessage = nil
    }.catch { error in
      self.errorMessage = error.localizedDescription
    }.finally {
      self.isLoading = false
    }
  }
  
  func fetchGitHubUser(with login: String) {
    isLoading = true
    apiService.fetchUser(with: login).done { user in
      self.users = [ user ]
      self.errorMessage = nil
    }.catch { error in
      self.users = []
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
