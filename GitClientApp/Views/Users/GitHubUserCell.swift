//
//  GitHubUserCell.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 22/05/23.
//

import UIKit
import SnapKit
import Kingfisher

final class GitHubUserCell: BaseTableViewCell {
    
  // MARK: - Properties
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 16
    return stackView
  }()
  
  private lazy var avatarView: AvatarView = {
    let avatarView = AvatarView()
    return avatarView
  }()
  
  private lazy var loginLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  // MARK: - Layout
  
  override func setupLayout() {
    super.setupLayout()
    accessoryType = .disclosureIndicator
    stackView.addArrangedSubview(avatarView)
    stackView.addArrangedSubview(loginLabel)
    contentView.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    avatarView.snp.makeConstraints { make in
      make.size.equalTo(80)
    }
  }
  
  // MARK: - Data
    
  func configure(with viewModel: GitHubUserViewModel) {
    loginLabel.text = viewModel.login
    avatarView.kf.setImage(with: viewModel.avatarURL)
  }
}
