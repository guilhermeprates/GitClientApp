//
//  UICollectionViewExtensions.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import UIKit

// MARK: - Methods

public extension UICollectionView {
  
  func numberOfItems() -> Int {
    var section = 0
    var itemsCount = 0
    while section < numberOfSections {
      itemsCount += numberOfItems(inSection: section)
      section += 1
    }
    return itemsCount
  }
  
  func reloadData(_ completion: @escaping () -> Void) {
       UIView.animate(withDuration: 0, animations: {
           self.reloadData()
       }, completion: { _ in
           completion()
       })
   }
  
  func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
    register(T.self, forCellWithReuseIdentifier: identifier)
  }
  
  func dequeueReusableCell<T: UICollectionViewCell>(
    withClass name: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
      fatalError(
        "Couldn't find UICollectionViewCell for \(identifier), make sure the cell is registered with collection view")
    }
    return cell
  }
  
  func register<T: UICollectionReusableView>(
    supplementaryViewOfKind kind: String,
    withClass name: T.Type
  ) {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
  }
  
  func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
    ofKind kind: String,
    withClass name: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard let cell = dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: identifier,
      for: indexPath
    ) as? T else {
      fatalError(
        "Couldn't find UICollectionReusableView for \(identifier), make sure the view is registered with collection view")
    }
    return cell
  }
}
