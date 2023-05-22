//
//  APIError.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation

enum APIError: Error {
  case noInternetConnection
  case badAPIRequest
  case unauthorized
  case unknown
  case invalidURL
}
