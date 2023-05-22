//
//  GitHubUserListViewController.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import UIKit
import SnapKit

final class GitHubUserListViewController: BaseViewController {
  
  // MARK: - Properties
  
  private let viewModel: GitHubUserListViewModel
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.tableFooterView = UIView()
    return tableView
  }()
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(
      self,
      action: #selector(self.didPullToRefresh(_:)),
      for: .valueChanged
    )
    return refreshControl
  }()
  
  private lazy var activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    return activityIndicatorView
  }()
  
  // MARK: - Initializers
  
  init(viewModel: GitHubUserListViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "GitHub Users"
    viewModel.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(cellWithClass: GitHubUserCell.self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchGitHubUsers()
  }
  
  // MARK: - Layout
  
  override func setupLayout() {
    super.setupLayout()
    tableView.refreshControl = refreshControl
    tableView.addSubview(activityIndicatorView)
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    activityIndicatorView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  // MARK: - Actions
  
  @objc
  func didPullToRefresh(_ sender: AnyObject) {
    viewModel.fetchGitHubUsers()
  }
}

// MARK: - GitHubUserListViewModelDelegate
extension GitHubUserListViewController: GitHubUserListViewModelDelegate {
  
  func didUpdateUserList() {
    tableView.reloadData()
  }
  
  func didUpdateLoadingStatus() {
    if viewModel.isLoading && viewModel.numberOfUsers == 0 {
      activityIndicatorView.startAnimating()
    } else {
      refreshControl.endRefreshing()
      activityIndicatorView.stopAnimating()
    }
  }
  
  func didUpdateErrorMessage() {
    guard let errorMessage = viewModel.errorMessage else { return }
    showAlert(title: "Erro", message: errorMessage)
  }
}

// MARK: - UITableViewDelegate
extension GitHubUserListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
}

// MARK: - UITableViewDataSource
extension GitHubUserListViewController: UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.numberOfUsers
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withClass: GitHubUserCell.self, for: indexPath)
    let user = viewModel.getUser(at: indexPath.row)
    cell.configure(with: GitHubUserViewModel(user: user))
    return cell
  }
}
