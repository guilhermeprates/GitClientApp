//
//  GitHubUserViewModelTests.swift
//  GitClientAppTests
//
//  Created by Guilherme Prates on 23/05/23.
//

import XCTest
import PromiseKit

class GitHubUserViewModelTests: XCTestCase {

  var viewModel: GitHubUserViewModel!
  
  var mockAPIService: MockGitHubAPIService!
  
  override func setUp() {
    super.setUp()
    
    let mockGitHubUsersPromise = Promise<GitHubUsers> { seal in
      seal.fulfill([])
    }
    let mockGitHubUserPromise = Promise<GitHubUser> { seal in
      seal.fulfill(guilhermePrates)
    }
    let mockGitHubRepositoriesPromise = Promise<GitHubRepositories> { seal in
      seal.fulfill([])
    }
    
    mockAPIService = MockGitHubAPIService(
      mockGitHubUsersPromise: mockGitHubUsersPromise,
      mockGitHubUserPromise: mockGitHubUserPromise,
      mockGitHubRepositoriesPromise: mockGitHubRepositoriesPromise
    )
    
    viewModel = GitHubUserViewModel(
      user: guilhermePrates,
      apiService: mockAPIService
    )
  }
  
  override func tearDown() {
    viewModel = nil
    mockAPIService = nil
    super.tearDown()
  }
  
  func testFetchGitHubRepositories_Success() {
    // Given
    let mockGitHubRepositoriesPromise = Promise<GitHubRepositories> { seal in
      seal.fulfill(guilhermePratesRepositories)
    }
    
    self.mockAPIService.mockGitHubRepositoriesPromise = mockGitHubRepositoriesPromise
  
    // When
    viewModel.fetchGitHubRepositories()
    
    // Then
    XCTAssertTrue(viewModel.isLoading)
    
    // Wait for the API call to finish
    let expectation = XCTestExpectation(description: "Fetch repositories")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertFalse(self.viewModel.isLoading)
      XCTAssertEqual(self.viewModel.numberOfRepositories, 6)
      XCTAssertEqual(self.viewModel.getRepository(at: 0).name, "GitClientApp")
      XCTAssertEqual(self.viewModel.getRepository(at: 1).name, "guilhermeprates.github.io")
      XCTAssertEqual(self.viewModel.getRepository(at: 2).name, "guilhermeprates")
      XCTAssertEqual(self.viewModel.getRepository(at: 3).name, "Coordinator-Pattern-Example")
      XCTAssertEqual(self.viewModel.getRepository(at: 4).name, "WorkingWithXibAndTableViewCell")
      XCTAssertEqual(self.viewModel.getRepository(at: 5).name, "ubuntu-ml-setup")
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 2)
  }
  
  func testFetchGitHubRepositories_Failure_BadAPIRequest() {
    // Given
    let errorMessage = APIError.badAPIRequest.description
    
    let mockGitHubRepositoriesPromise = Promise<GitHubRepositories> { seal in
      seal.reject(APIError.badAPIRequest)
    }
 
    self.mockAPIService.mockGitHubRepositoriesPromise = mockGitHubRepositoriesPromise
  
    // When
    viewModel.fetchGitHubRepositories()
    
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
  
  func testFetchGitHubRepositories_Failure_NoInternetConnection() {
    // Given
    let errorMessage = APIError.noInternetConnection.description
    
    let mockGitHubRepositoriesPromise = Promise<GitHubRepositories> { seal in
      seal.reject(APIError.noInternetConnection)
    }
 
    self.mockAPIService.mockGitHubRepositoriesPromise = mockGitHubRepositoriesPromise
  
    // When
    viewModel.fetchGitHubRepositories()
    
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
  
  func testFetchGitHubRepositories_Failure_Unknown() {
    // Given
    let errorMessage = APIError.unknown.description
    
    let mockGitHubRepositoriesPromise = Promise<GitHubRepositories> { seal in
      seal.reject(APIError.unknown)
    }
 
    self.mockAPIService.mockGitHubRepositoriesPromise = mockGitHubRepositoriesPromise
  
    // When
    viewModel.fetchGitHubRepositories()
    
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
  
}
