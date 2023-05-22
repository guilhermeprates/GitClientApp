//
//  GitHubUser.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation
import Alamofire

typealias GitHubUsers = [GitHubUser]

struct GitHubUser {
  var id: Int
  var login: String
  var avatarURL: URL?
  var type: String
  var siteAdmin: Bool
  var name: String
  var bio: String
  var location: String
  var followers: Int
  var following: Int
}

extension GitHubUser {
  
  static func getGitHubUsers() -> URLRequestConvertible {
    do {
      return try APIRequest(method: .get, path: "/users").asURLRequest()
    } catch {
      fatalError()
    }
  }
  
  static func getGitHubUser(with login: String) -> URLRequestConvertible {
    do {
      return try APIRequest(method: .get, path: "/users/\(login)").asURLRequest()
    } catch {
      fatalError()
    }
  }
}
extension GitHubUser: Codable {
  
  enum CodingKeys: String, CodingKey {
    case id, login, type, name, location,
         bio, followers, following
    case avatarURL = "avatar_url"
    case siteAdmin = "site_admin"
   }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    login = try values.decode(String.self, forKey: .login)
    avatarURL = try values.decode(URL.self, forKey: .avatarURL)
    type = try values.decode(String.self, forKey: .type)
    siteAdmin = try values.decode(Bool.self, forKey: .siteAdmin)
    name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    bio = try values.decodeIfPresent(String.self, forKey: .bio) ?? ""
    location = try values.decodeIfPresent(String.self, forKey: .location) ?? ""
    followers = try values.decodeIfPresent(Int.self, forKey: .followers) ?? 0
    following = try values.decodeIfPresent(Int.self, forKey: .following) ?? 0
  }
}

