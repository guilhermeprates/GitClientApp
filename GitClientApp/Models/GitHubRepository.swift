//
//  GitHubRepository.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation
import Alamofire

typealias GitHubRepositories = [GitHubRepository]

struct GitHubRepository {
  var id: Int
  var name: String
  var fullName: String
  var isPrivate: Bool
  var owner: GitHubUser
  var description: String
  var isFork: Bool
  var language: String
}

extension GitHubRepository {
  
  static func getGitHubRepositories(for login: String) -> URLRequestConvertible {
    do {
      return try APIRequest(method: .get, path: "/users/\(login)/repos").asURLRequest()
    } catch {
      fatalError()
    }
  }
}

extension GitHubRepository: Codable {
  
  enum CodingKeys: String, CodingKey {
    case id, name, fullName = "full_name",
         owner, description, language,
         isPrivate = "private", isFork = "fork"
   }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    name = try values.decode(String.self, forKey: .name)
    fullName = try values.decode(String.self, forKey: .fullName)
    owner = try values.decode(GitHubUser.self, forKey: .owner)
    description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
    language = try values.decodeIfPresent(String.self, forKey: .language) ?? ""
    isPrivate = try values.decode(Bool.self, forKey: .isPrivate)
    isFork = try values.decode(Bool.self, forKey: .isFork)
  }
}

