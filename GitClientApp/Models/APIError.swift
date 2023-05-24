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
  case dataNotFound
  case unknown
  case invalidURL
}

extension APIError {
  
  var description: String {
    switch self {
    case .noInternetConnection:
      return "Sem conexão com a Internet."
    case .badAPIRequest:
      return "Erro na requisição."
    case .dataNotFound:
      return "Informação não encontrada."
    case .unknown:
      return "Erro desconhecido."
    case .invalidURL:
      return "URL inválida."
    }
  }
}
