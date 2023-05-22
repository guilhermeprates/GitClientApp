//
//  GitHubUserViewModel.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 22/05/23.
//

import Foundation

final class GitHubUserViewModel {
  
  private let user: GitHubUser
  
  var login: String {
    return user.login
  }
  
  var avatarURL: URL? {
    return user.avatarURL
  }
  
  init(user: GitHubUser) {
    self.user = user
  }
}
