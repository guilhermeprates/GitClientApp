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
        GitHubUser(id: 0, login: "guilhermeprates", avatarURL: nil, type: "user", siteAdmin: false)
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
      GitHubUser(id: 0, login: "guilhermeprates", avatarURL: nil, type: "user", siteAdmin: false),
      GitHubUser(id: 1, login: "torvalds", avatarURL: nil, type: "user", siteAdmin: false)
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
  
  func testFetchGitHubUsers_Failure() {
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
  
  func testFetchGitHubUser_UserFound_Success() {
    // Given
    let login = "guilhermeprates"
    
    let mockGitHubUserPromise = Promise<GitHubUser> { seal in
      seal.fulfill(
        GitHubUser(id: 0, login: "guilhermeprates", avatarURL: nil, type: "user", siteAdmin: false)
      )
    }
    
    self.mockAPIService.mockGitHubUserPromise = mockGitHubUserPromise
  
    // When
    viewModel.fetchGitHubUser(with: login)
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch user")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.numberOfUsers, 1)
      XCTAssertEqual(self.viewModel.getUser(at: 0).login, "guilhermeprates")
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubUser_Failure() {
    // Given
    let login = "guilhermeprats"
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
    let expectation = XCTestExpectation(description: "Fetch user")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.errorMessage, errorMessage)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
}
