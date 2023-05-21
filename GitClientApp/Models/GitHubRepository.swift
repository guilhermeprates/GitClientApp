//
//  GitHubRepository.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

typealias GitHubRepositories = [GitHubRepository]

struct GitHubRepository {
  var id: Int
  var name: String
  var fullName: String
  var isPrivate: Bool
  var owner: GitHubUser
  var description: String
  var isFork: Bool
  var createAt: Date
  var updateAt: Date
  var language: String
  var visibility: String
}
