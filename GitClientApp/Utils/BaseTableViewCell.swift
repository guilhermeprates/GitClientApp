//
//  BaseTableViewCell.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 22/05/23.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

  // MARK: - Initializers
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupLayout()
  }
  
  // MARK: - Layout
  
  func setupLayout() {
    selectionStyle = .none
  }
}
