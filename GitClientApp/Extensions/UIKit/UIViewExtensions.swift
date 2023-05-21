//
//  UIViewExtensions.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import UIKit

// MARK: - Properties

public extension UIView {
  
  var identifier: String {
    return String(describing: self)
  }
  
  @IBInspectable
  var layerBorderColor: UIColor? {
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
    set {
      guard let color = newValue else {
        layer.borderColor = nil
        return
      }
      layer.borderColor = color.cgColor
    }
  }
  
  @IBInspectable
  var layerBorderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var layerCornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.masksToBounds = true
      layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
    }
  }
  
  
  @IBInspectable
  var layerShadowColor: UIColor? {
    get {
      guard let color = layer.shadowColor else { return nil }
      return UIColor(cgColor: color)
    }
    set {
      layer.shadowColor = newValue?.cgColor
    }
  }
  
  @IBInspectable
  var layerShadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable
  var layerShadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable
  var layerShadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }
  
  @IBInspectable
  var masksToBounds: Bool {
    get {
      return layer.masksToBounds
    }
    set {
      layer.masksToBounds = newValue
    }
  }
  
  var size: CGSize {
    get {
      return frame.size
    }
    set {
      width = newValue.width
      height = newValue.height
    }
  }
  
  var width: CGFloat {
    get {
      return frame.size.width
    }
    set {
      frame.size.width = newValue
    }
  }
  
  var height: CGFloat {
    get {
      return frame.size.height
    }
    set {
      frame.size.height = newValue
    }
  }
}

// MARK: - Methods

public extension UIView {
  
  func addShadow(
    ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0),
    radius: CGFloat = 3,
    offset: CGSize = .zero,
    opacity: Float = 0.5
  ) {
    layer.shadowColor = color.cgColor
    layer.shadowOffset = offset
    layer.shadowRadius = radius
    layer.shadowOpacity = opacity
    layer.masksToBounds = false
  }
  
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let maskPath = UIBezierPath(
      roundedRect: bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    
    let shape = CAShapeLayer()
    shape.path = maskPath.cgPath
    layer.mask = shape
  }
  
  func addSubviews(_ subviews: [UIView]) {
    subviews.forEach { addSubview($0) }
  }
  
  func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
    if isHidden {
      isHidden = false
    }
    UIView.animate(withDuration: duration, animations: {
      self.alpha = 1
    }, completion: completion)
  }
  
  func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
    if isHidden {
      isHidden = false
    }
    UIView.animate(withDuration: duration, animations: {
      self.alpha = 0
    }, completion: completion)
  }
}
