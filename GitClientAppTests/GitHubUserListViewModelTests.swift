//
//  GitHubUserListViewModelTests.swift
//  GitClientAppTests
//
//  Created by Guilherme Prates on 22/05/23.
//

import XCTest
import PromiseKit

class GitHubUserListViewModelTests: XCTestCase {
  
  var viewModel: GitHubUserListViewModel!
  var mockAPIService: MockGitHubAPIService!
  
  override func setUp() {
    super.setUp()
    
    let mockGitHubUsersPromise = Promise<GitHubUsers> { seal in
      seal.fulfill([])
    }
    
    let mockGitHubUserPromise = Promise<GitHubUser> { seal in
      seal.fulfill(
        GitHubUser(
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
      )
    }
    
    let mockGitHubRepositoriesPromise = Promise<GitHubRepositories> { seal in
      seal.fulfill([])
    }
    
    mockAPIService = MockGitHubAPIService(
      mockGitHubUsersPromise: mockGitHubUsersPromise,
      mockGitHubUserPromise: mockGitHubUserPromise,
      mockGitHubRepositoriesPromise: mockGitHubRepositoriesPromise
    )
    viewModel = GitHubUserListViewModel(apiService: mockAPIService)
  }
  
  override func tearDown() {
    viewModel = nil
    mockAPIService = nil
    super.tearDown()
  }
  
  func testFetchGitHubUsers_Success() {
    // Given
    let users = [
      GitHubUser(
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
      ),
      GitHubUser(
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
    ]
    
    let mockGitHubUsersPromise = Promise<GitHubUsers> { seal in
      seal.fulfill(users)
    }
    
    self.mockAPIService.mockGitHubUsersPromise = mockGitHubUsersPromise
  
    // When
    viewModel.fetchGitHubUsers()
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch users")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.numberOfUsers, 2)
      XCTAssertEqual(self.viewModel.getUser(at: 0).login, "guilhermeprates")
      XCTAssertEqual(self.viewModel.getUser(at: 1).login, "torvalds")
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUsers_Failure_BadAPIRequest() {
    // Given
    let errorMessage = APIError.badAPIRequest.localizedDescription
    
    let mockGitHubUsersPromise = Promise<GitHubUsers> { seal in
      seal.reject(APIError.badAPIRequest)
    }
    
    self.mockAPIService.mockGitHubUsersPromise = mockGitHubUsersPromise
  
    // When
    viewModel.fetchGitHubUsers()
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch users")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.errorMessage, errorMessage)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUsers_Failure_NoInternetConnection() {
    // Given
    let errorMessage = APIError.noInternetConnection.localizedDescription
    
    let mockGitHubUsersPromise = Promise<GitHubUsers> { seal in
      seal.reject(APIError.noInternetConnection)
    }
    
    self.mockAPIService.mockGitHubUsersPromise = mockGitHubUsersPromise
  
    // When
    viewModel.fetchGitHubUsers()
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch users")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.errorMessage, errorMessage)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUsers_Failure_Unknown() {
    // Given
    let errorMessage = APIError.unknown.localizedDescription
    
    let mockGitHubUsersPromise = Promise<GitHubUsers> { seal in
      seal.reject(APIError.unknown)
    }
    
    self.mockAPIService.mockGitHubUsersPromise = mockGitHubUsersPromise
  
    // When
    viewModel.fetchGitHubUsers()
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch users")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.errorMessage, errorMessage)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUser_Success() {
    // Given
    let login = "guilhermeprates"
    
    let mockGitHubUserPromise = Promise<GitHubUser> { seal in
      seal.fulfill(
        GitHubUser(
          id: 0,
          login: "guilhermeprates",
          avatarURL: nil,
          type: "User",
          siteAdmin: false,
          name: "Guilherme Prates",
          bio: "iOS Software Engineer",
          location: "Brazil",
          followers: 34,
          following: 33
        )
      )
    }
    
    self.mockAPIService.mockGitHubUserPromise = mockGitHubUserPromise
  
    // When
    viewModel.fetchGitHubUser(with: login)
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch user with \(login)")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.numberOfUsers, 1)
      XCTAssertEqual(self.viewModel.getUser(at: 0).login, "guilhermeprates")
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUser_Failure_DataNotFound() {
    // Given
    let login = "guilhermeprats"
    let errorMessage = APIError.dataNotFound.localizedDescription
    
    let mockGitHubUserPromise = Promise<GitHubUser> { seal in
      seal.reject(APIError.dataNotFound)
    }
    
    self.mockAPIService.mockGitHubUserPromise = mockGitHubUserPromise
  
    // When
    viewModel.fetchGitHubUser(with: login)
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch user with \(login)")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.errorMessage, errorMessage)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUser_Failure_BadAPIRequest() {
    // Given
    let login = "guilhermeprates"
    let errorMessage = APIError.badAPIRequest.localizedDescription
    
    let mockGitHubUserPromise = Promise<GitHubUser> { seal in
      seal.reject(APIError.badAPIRequest)
    }
    
    self.mockAPIService.mockGitHubUserPromise = mockGitHubUserPromise
  
    // When
    viewModel.fetchGitHubUser(with: login)
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch user with \(login)")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.errorMessage, errorMessage)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUser_Failure_NoInternetConnection() {
    // Given
    let login = "guilhermeprates"
    let errorMessage = APIError.noInternetConnection.localizedDescription
    
    let mockGitHubUserPromise = Promise<GitHubUser> { seal in
      seal.reject(APIError.noInternetConnection)
    }
    
    self.mockAPIService.mockGitHubUserPromise = mockGitHubUserPromise
  
    // When
    viewModel.fetchGitHubUser(with: login)
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch user with \(login)")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.errorMessage, errorMessage)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUser_Failure_Unknown() {
    // Given
    let login = "guilhermeprates"
    let errorMessage = APIError.unknown.localizedDescription
    
    let mockGitHubUserPromise = Promise<GitHubUser> { seal in
      seal.reject(APIError.unknown)
    }
    
    self.mockAPIService.mockGitHubUserPromise = mockGitHubUserPromise
  
    // When
    viewModel.fetchGitHubUser(with: login)
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch user with \(login)")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.errorMessage, errorMessage)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
}
