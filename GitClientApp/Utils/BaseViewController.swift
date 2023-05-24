//
//  BaseViewController.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import UIKit

class BaseViewController: UIViewController {
  
  // MARK: - Initializers
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("This class does not support NSCoder")
  }
  
  // MARK: - View life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupLayout()
  }
  
  // MARK: - Layout
  
  func setupLayout() {
    view.backgroundColor = .white
  }
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.tintColor = .darkText

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    appearance.shadowColor = .clear
    appearance.shadowImage = UIImage()
  
    appearance.titleTextAttributes = [.foregroundColor: UIColor.darkText]
    navigationItem.standardAppearance = appearance
    navigationItem.scrollEdgeAppearance = appearance
    navigationItem.compactAppearance = appearance
    
    let buttonAppearance = UIBarButtonItemAppearance()
    buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.darkText]
    
    navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
 
    if let navigationBar = self.navigationController?.navigationBar {
      let standardAppearance = UINavigationBarAppearance()
      standardAppearance.configureWithOpaqueBackground()
      standardAppearance.backgroundImage = nil

      let compactAppearance = standardAppearance.copy()
      compactAppearance.backgroundImage = nil
      
      navigationBar.standardAppearance = standardAppearance
      navigationBar.scrollEdgeAppearance = standardAppearance
      navigationBar.compactAppearance = compactAppearance
    }
  }
}
