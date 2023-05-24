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
  
  private let apiService: GitHubAPIService
  
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
    apiService.fetchUsers().done { [weak self] users in
      self?.users = users
      self?.errorMessage = nil
    }.catch { [weak self] error in
      self?.errorMessage = self?.handleAPIError(error: error)
    }.finally { [weak self] in
      self?.isLoading = false
    }
  }
  
  func fetchGitHubUser(with login: String) {
    isLoading = true
    apiService.fetchUser(with: login).done { [weak self] user in
      self?.users = [ user ]
      self?.errorMessage = nil
    }.catch { [weak self] error in
      self?.users = []
      self?.errorMessage = self?.handleAPIError(error: error)
    }.finally { [weak self] in
      self?.isLoading = false
    }
  }
  
  private func handleAPIError(error: Error) -> String {
    guard let error = error as? APIError else {
      return error.localizedDescription
    }
    return error.description
  }
  
  // MARK: - Data Access
  
  func getUser(at index: Int) -> GitHubUser {
    return users[index]
  }
}
