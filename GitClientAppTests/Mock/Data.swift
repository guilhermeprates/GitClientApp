//
//  Data.swift
//  GitClientAppTests
//
//  Created by Guilherme Prates on 23/05/23.
//

import Foundation

let guilhermePrates = GitHubUser(
  id: 1538573,
  login: "guilhermeprates",
  avatarURL: URL(string: "https://avatars.githubusercontent.com/u/1538573?v=4"),
  type: "User",
  siteAdmin: false,
  name: "Guilherme Prates",
  bio: "iOS Software Engineer",
  location: "Brazil",
  followers: 34,
  following: 33
)

let torvalds = GitHubUser(
  id: 1024025,
  login: "torvalds",
  avatarURL: URL(string: "https://avatars.githubusercontent.com/u/1024025?v=4"),
  type: "User",
  siteAdmin: false,
  name: "Linus Torvalds",
  bio: "",
  location: "Portland, OR",
  followers: 183000,
  following: 0
)


let users = [ guilhermePrates, torvalds ]

let guilhermePratesRepositories = [
  GitHubRepository(
    id: 0,
    name: "GitClientApp",
    fullName: "guilhermeprates/GitClientApp",
    isPrivate: false,
    owner: guilhermePrates,
    description: "",
    isFork: false,
    language: "Swift"
  ),
  GitHubRepository(
    id: 311359758,
    name: "guilhermeprates.github.io",
    fullName: "guilhermeprates/guilhermeprates.github.io",
    isPrivate: false,
    owner: guilhermePrates,
    description: "",
    isFork: false,
    language: "HTML"
  ),
  GitHubRepository(
    id: 330011370,
    name: "guilhermeprates",
    fullName: "guilhermeprates/guilhermeprates",
    isPrivate: false,
    owner: guilhermePrates,
    description: "",
    isFork: false,
    language: ""
  ),
  GitHubRepository(
    id: 171534485,
    name: "Coordinator-Pattern-Example",
    fullName: "guilhermeprates/Coordinator-Pattern-Example",
    isPrivate: false,
    owner: guilhermePrates,
    description: "An example of the coordinator pattern in iOS.",
    isFork: false,
    language: "Swift"
  ),
  GitHubRepository(
    id: 105950066,
    name: "WorkingWithXibAndTableViewCell",
    fullName: "guilhermeprates/WorkingWithXibAndTableViewCell",
    isPrivate: false,
    owner: guilhermePrates,
    description: "An example of how to use TableViewCell with Xib.",
    isFork: false,
    language: "Swift"
  ),
  GitHubRepository(
    id: 133987811,
    name: "ubuntu-ml-setup",
    fullName: "guilhermeprates/ubuntu-ml-setup",
    isPrivate: false,
    owner: guilhermePrates,
    description: "Ubuntu machine learning setup.",
    isFork: false,
    language: "Shell"
  )

  
  
]
