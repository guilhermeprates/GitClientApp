//
//  Request.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation
import Alamofire

final class APIRequest: URLRequestConvertible {
  
  // MARK: - Properties
  
  var method: HTTPMethod

  var path: String
    
  var parameters: Parameters?

  var body: Parameters?
    
  // MARK: - Initializers
  
  init(method: HTTPMethod, path: String, parameters: Parameters? = nil, body: Parameters? = nil) {
    self.method = method
    self.path = path
    self.parameters = parameters
    self.body = body
  }
  
  // MARK: - Methods
  
  func asURLRequest() throws -> URLRequest {
    guard let url = URL(string: "https://api.github.com") else {
      fatalError("Failed to load URL string.")
    }
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    
    if let body = body {
      do {
        let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        urlRequest.httpBody = data
      } catch {
        fatalError("Failed to parse body into request.")
      }
    }
    
    if let parameters = parameters {
      let urlEnconding = URLEncoding(
        destination: .methodDependent,
        arrayEncoding: .noBrackets,
        boolEncoding: .literal
      )
      urlRequest = try urlEnconding.encode(urlRequest, with: parameters)
    }
    
    return urlRequest
  }
}
