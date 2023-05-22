//
//  AvatarView.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 22/05/23.
//

import UIKit

class AvatarView: UIImageView {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layerCornerRadius = size.height / 2
    clipsToBounds = true
  }
}
