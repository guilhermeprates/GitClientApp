//
//  GitHubUserDetailsViewController.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 23/05/23.
//

import UIKit

final class GitHubUserDetailsViewController: BaseViewController {
  
  // MARK: - Properties
  
  private let viewModel: GitHubUserViewModel
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: makeCollectionViewLayout()
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  
  private lazy var activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    return activityIndicatorView
  }()
  
  // MARK: - Initializers
  
  init(viewModel: GitHubUserViewModel) {
    self.viewModel = viewModel
    super.init()
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchGitHubRepositories()
  }
  
  // MARK: - Layout
  
  override func setupLayout() {
    super.setupLayout()
    view.addSubview(collectionView)
    collectionView.addSubview(activityIndicatorView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    activityIndicatorView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}

// MARK: - GitHubUserViewModelDelegate
extension GitHubUserDetailsViewController: GitHubUserViewModelDelegate {
  
  func didUpdateRepositoryList() {
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }
  
  func didUpdateLoadingStatus() {
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      if strongSelf.viewModel.isLoading && strongSelf.viewModel.numberOfRepositories == 0 {
        strongSelf.activityIndicatorView.startAnimating()
      } else {
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

// MARK: - UICollectionView
private extension GitHubUserDetailsViewController {
  
  typealias Cell = GitHubRepositoryCell
  typealias CellRegistration = UICollectionView.CellRegistration<Cell, GitHubRepositoryViewModel>
  typealias Header = GitHubUserHeaderView
  typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<Header>
  
  func makeCellRegistration() -> CellRegistration {
    return CellRegistration { cell, _, viewModel in
      cell.configure(with: viewModel)
    }
  }
  
  func makeHeaderRegistration() -> HeaderRegistration {
    let elementKind = UICollectionView.elementKindSectionHeader
    return HeaderRegistration(elementKind: elementKind) { header, _, _ in
      header.configure(with: self.viewModel)
    }
  }
  
  func makeListLayoutSection() -> NSCollectionLayoutSection {
    let itemLayoutSize =  NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .fractionalHeight(1)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
    
    let groupLayoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .absolute(48)
    )
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: groupLayoutSize,
      subitems: [item]
    )
    
    return NSCollectionLayoutSection(group: group)
  }
  
  func makeCollectionViewLayout() -> UICollectionViewLayout {
    return  UICollectionViewCompositionalLayout { [weak self] _, _ in
      let section = self?.makeListLayoutSection()
      
      let headerSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(240)
      )
      let elementKind = UICollectionView.elementKindSectionHeader
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: headerSize,
        elementKind: elementKind,
        alignment: .top
      )
      section?.boundarySupplementaryItems = [ sectionHeader ]
      return section
    }
  }
}

// MARK: - UICollectionViewDelegate
extension GitHubUserDetailsViewController: UICollectionViewDelegate {
  
}

// MARK: - UICollectionViewDataSource
extension GitHubUserDetailsViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfRepositories
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let repository = viewModel.getRepository(at: indexPath.row)
    let cell = collectionView.dequeueConfiguredReusableCell(
      using: makeCellRegistration(),
      for: indexPath,
      item: GitHubRepositoryViewModel(repository: repository)
    )
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    let header = collectionView.dequeueConfiguredReusableSupplementary(
      using: makeHeaderRegistration(),
      for: indexPath
    )
    return header
  }
}


