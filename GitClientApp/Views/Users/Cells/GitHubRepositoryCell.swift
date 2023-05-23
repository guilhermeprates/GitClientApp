//
//  GitHubRepositoryCell.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 23/05/23.
//

import UIKit
import SnapKit

final class GitHubRepositoryCell: BaseCollectionViewCell {
  
  // MARK: - Properties
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textAlignment = .left
    label.numberOfLines = 1
    return label
  }()
  
  // MARK: - Layout
  
  override func setupLayout() {
    super.setupLayout()
    contentView.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  // MARK: - Data
    
  func configure(with viewModel: GitHubRepositoryViewModel) {
    nameLabel.text = viewModel.name
  }
}
