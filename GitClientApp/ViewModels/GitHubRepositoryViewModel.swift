//
//  GitHubRepositoryViewModel.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 23/05/23.
//

import Foundation

final class GitHubRepositoryViewModel {
  
  private let repository: GitHubRepository
  
  var name: String {
    return repository.name
  }
  
  var description: String {
    return repository.description
  }
  
  var language: String {
    return repository.language
  }
  
  init(repository: GitHubRepository) {
    self.repository = repository
  }
}
