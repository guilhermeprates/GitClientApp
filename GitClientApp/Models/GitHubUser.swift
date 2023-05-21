//
//  GitHubUser.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

typealias GitHubUsers = [GitHubUser]

struct GitHubUser {
  var id: Int
  var login: String
  var avatarURL: URL?
  var type: String
  var siteAdmin: Bool
}
