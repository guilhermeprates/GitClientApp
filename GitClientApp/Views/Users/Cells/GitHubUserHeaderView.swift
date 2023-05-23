//
//  GitHubUserHeaderView.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 23/05/23.
//

import UIKit

final class GitHubUserHeaderView: BaseHeaderView {
  
  // MARK: - Properties
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 4
    return stackView
  }()
  
  private lazy var avatarView: AvatarView = {
    let avatarView = AvatarView()
    avatarView.translatesAutoresizingMaskIntoConstraints = false
    return avatarView
  }()
  
  private lazy var loginLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textAlignment = .center
    label.numberOfLines = 1
    return label
  }()
  
  private lazy var repositoriesTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.preferredFont(forTextStyle: .title2)
    label.textAlignment = .left
    label.numberOfLines = 1
    label.text = "Repositórios"
    return label
  }()
  
  // MARK: - Layout
  
  override func setupLayout() {
    super.setupLayout()
    stackView.addArrangedSubview(avatarView)
    stackView.addArrangedSubview(loginLabel)
    addSubview(stackView)
    addSubview(repositoriesTitleLabel)
    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
    avatarView.snp.makeConstraints { make in
      make.size.equalTo(80)
    }
    repositoriesTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(stackView.snp.bottom).offset(16)
      make.bottom.equalToSuperview().inset(16)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  // MARK: - Data
  
  func configure(with viewModel: GitHubUserViewModel) {
    loginLabel.text = viewModel.login
    avatarView.kf.setImage(with: viewModel.avatarURL)
  }
}
