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
  
  private lazy var searchController: UISearchController = {
    let searchController = UISearchController()
    searchController.searchBar.placeholder = "Insira o login do usuário"
    searchController.searchBar.searchBarStyle = .minimal
    searchController.obscuresBackgroundDuringPresentation = false
    return searchController
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.tableHeaderView = UIView()
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
    title = "Usuários"
    viewModel.delegate = self
    searchController.searchBar.delegate = self
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
    navigationItem.searchController = searchController
    searchController.searchBar.tintColor = .darkText
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
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  func didUpdateLoadingStatus() {
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      if strongSelf.viewModel.isLoading && strongSelf.viewModel.numberOfUsers == 0 {
        strongSelf.activityIndicatorView.startAnimating()
      } else {
        strongSelf.refreshControl.endRefreshing()
        strongSelf.activityIndicatorView.stopAnimating()
      }
    }
  }
  
  func didUpdateErrorMessage() {
    DispatchQueue.main.async { [weak self] in
      guard let errorMessage = self?.viewModel.errorMessage else { return }
      self?.showAlert(title: "Erro", message: errorMessage)
    }
  }
}

// MARK: - UITableViewDelegate
extension GitHubUserListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    searchController.dismiss(animated: true) {
      self.searchController.searchBar.text = ""
      let user = self.viewModel.getUser(at: indexPath.row)
      let viewModel = GitHubUserViewModel(user: user)
      let viewController = GitHubUserDetailsViewController(viewModel: viewModel)
      self.navigationController?.pushViewController(viewController, animated: true)
    }
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

// MARK: - UISearchBarDelegate
extension GitHubUserListViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchBar.text = searchText.lowercased()
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    guard let login = searchController.searchBar.text, !login.isEmpty else { return }
    viewModel.fetchGitHubUser(with: login)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.fetchGitHubUsers()
  }
}
