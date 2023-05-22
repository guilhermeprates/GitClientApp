//
//  DataExtensions.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

// MARK: - Methods

public extension Data {
  
  func string(encoding: String.Encoding) -> String? {
    return String(data: self, encoding: encoding)
  }
}
