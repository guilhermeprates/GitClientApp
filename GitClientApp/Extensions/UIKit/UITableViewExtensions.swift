//
//  UITableViewExtensions.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import UIKit

// MARK: - Methods

public extension UITableView {
  
  func reloadData(_ completion: @escaping () -> Void) {
    UIView.animate(withDuration: 0, animations: {
      self.reloadData()
    }, completion: { _ in
      completion()
    })
  }
  
  func removeTableFooterView() {
    tableFooterView = nil
  }
  
  func removeTableHeaderView() {
    tableHeaderView = nil
  }
  
  func removeSeparator() {
    separatorStyle = .none
  }
  
  func register<T: UITableViewCell>(cellWithClass name: T.Type) {
    register(T.self, forCellReuseIdentifier: T.identifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier) as? T else {
      fatalError(
        "Couldn't find UITableViewCell for \(T.identifier), make sure the cell is registered with table view")
    }
    return cell
  }
  
  func dequeueReusableCell<T: UITableViewCell>(
    withClass name: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError(
        "Couldn't find UITableViewCell for \(T.identifier), make sure the cell is registered with table view")
    }
    return cell
  }
  
  func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
      register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
  }

  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
    guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
          fatalError(
            "Couldn't find UITableViewHeaderFooterView for \(T.identifier), make sure the view is registered with table view")
      }
      return headerFooterView
  }
}
