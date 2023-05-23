//
//  BaseHeaderView.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 23/05/23.
//

import UIKit

class BaseHeaderView: UICollectionReusableView {
    
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupLayout()
  }
  
  // MARK: - Layout
  
  func setupLayout() {}
}
