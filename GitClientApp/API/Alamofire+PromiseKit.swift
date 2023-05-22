//
//  Alamofire+PromiseKit.swift
//  GitClientApp
//
//  Created by Guilherme Prates on 21/05/23.
//

import Foundation
import PromiseKit
import Alamofire

public extension Session {
  
  static func requestWithPromise<T: Codable>(
    _ urlConvertible: Alamofire.URLRequestConvertible
  ) -> Promise<T> {
    return Promise<T> { seal in
      AF.request(urlConvertible)
        .responseDecodable(
          emptyResponseCodes: [202, 204, 205]
        ) { (response: DataResponse<T, AFError>) in
          
          if let jsonString = response.data?.string(encoding: .utf8) {
            print(jsonString)
          }
          
          switch response.result {
          case .success(let value):
            seal.fulfill(value)
          case .failure(let error):
            let statusCode = response.response?.statusCode ?? 0
            print("Response - \(response)")
            print("API Error - An error occured, status code: \(statusCode)")
            print("API Error - Alamofire error: \(error)")
                        
            if let jsonString = response.data?.string(encoding: .utf8) {
              print(jsonString)
            }
            
            if let data = response.data,
               let json = String(data: data, encoding: String.Encoding.utf8) {
              print("API Error - Returned JSON: \(String(describing: json))")
            }
            switch response.response?.statusCode {
            case 404:
              seal.reject(APIError.dataNotFound)
            case 400:
              seal.reject(APIError.badAPIRequest)
            default:
              guard NetworkReachabilityManager()?.isReachable ?? false else {
                seal.reject(APIError.noInternetConnection)
                return
              }
              seal.reject(APIError.unknown)
            }
          }
        }
    }
  }
}
