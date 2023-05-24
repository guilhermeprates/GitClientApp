//
//  GitHubUserViewModel.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 22/05/23.
//

import Foundation

protocol GitHubUserViewModelDelegate: AnyObject {
  func didUpdateRepositoryList()
  func didUpdateLoadingStatus()
  func didUpdateErrorMessage()
}

final class GitHubUserViewModel {
  
  // MARK: - Properties
  
  private let apiService: GitHubAPIService
  
  private let user: GitHubUser
  
  private var repositories: GitHubRepositories = [] {
    didSet {
      delegate?.didUpdateRepositoryList()
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
  
  var numberOfRepositories: Int {
    return repositories.count
  }
  
  var login: String {
    return user.login
  }
  
  var avatarURL: URL? {
    return user.avatarURL
  }
  
  weak var delegate: GitHubUserViewModelDelegate?
  
  // MARK: Initializers
  
  init(user: GitHubUser, apiService: GitHubAPIService = GitHubAPIV3Service()) {
    self.user = user
    self.apiService = apiService
  }
  
  // MARK: - API Call
  
  func fetchGitHubRepositories() {
    isLoading = true
    apiService.fetchRepositories(for: user.login).done { [weak self] repositories in
      self?.repositories = repositories
      self?.errorMessage = nil
    }.catch { [weak self] error in
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
  
  func getRepository(at index: Int) -> GitHubRepository {
    return repositories[index]
  }
}
