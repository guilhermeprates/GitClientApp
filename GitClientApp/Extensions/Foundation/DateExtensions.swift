//
//  DateExtensions.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

// MARK: - Methods

public extension Date {
  
  func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = style
    dateFormatter.dateStyle = style
    return dateFormatter.string(from: self)
  }
}

// MARK: - Initializers

public extension Date {
  
  init?(iso8601String: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    guard let date = dateFormatter.date(from: iso8601String) else { return nil }
    self = date
    }
}
