//
//  NetworkManager.swift
//  FamilyGoV3
//
//  Created by Egor Ledkov on 08.12.2022.
//

import Foundation
import Combine

enum NetworkUrl: String {
  case check = "gateway/sys/healz"
  case signup = "gateway/user/signup"
  case login = "gateway/user/login"
  case keys = "gateway/user/keys"
}

final class NetworkManager {
  // MARK: - Private properties
  private let session: URLSession
  
  
  // MARK: - Initialize
  init() {
      let configuration = URLSessionConfiguration.default
    
      configuration.urlCache = nil
      configuration.requestCachePolicy = .reloadIgnoringCacheData
       
      session = URLSession(configuration: configuration)
  }
  
  
  // MARK: - Public methods
  func getData(from stringURL: String) -> AnyPublisher<Data, NetworkError> {
    guard let url = URL(string: stringURL) else {
      return Fail(error: NetworkError.badURL)
        .eraseToAnyPublisher()
    }
    
    let request = URLRequest(url: url)
        
    return fetch(request: request, in: session)
  }
  
  func postData(_ data: [String: Any], to stringURL: String) -> AnyPublisher<Data, NetworkError> {
    guard let url = URL(string: stringURL) else {
      return Fail(error: NetworkError.badURL)
        .eraseToAnyPublisher()
    }
    
    guard let postData = try? JSONSerialization.data(withJSONObject: data) else {
      return Fail(error: NetworkError.badEncode)
        .eraseToAnyPublisher()
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = postData
        
    return fetch(request: request, in: session)
  }
  
  func putData(_ data: [String: Any], with token: String, to stringURL: String) -> AnyPublisher<Data, NetworkError> {
    guard let url = URL(string: stringURL) else {
      return Fail(error: NetworkError.badURL)
        .eraseToAnyPublisher()
    }
    
    guard let putData = try? JSONSerialization.data(withJSONObject: data) else {
      return Fail(error: NetworkError.badEncode)
        .eraseToAnyPublisher()
    }
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue(token, forHTTPHeaderField: "Authorization")
    request.httpBody = putData
        
    return fetch(request: request, in: session)
  }
  
  
  // MARK: - Private methods
  private func fetch(request: URLRequest, in session: URLSession) -> AnyPublisher<Data, NetworkError> {
    URLSession.DataTaskPublisher(request: request, session: session)
      .print()
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw NetworkError.unknown
        }
                
        if httpResponse.statusCode != 200 {
          throw NetworkError.badResponse(
            reason: HTTPURLResponse.localizedString(
              forStatusCode: httpResponse.statusCode
            )
          )
        }

        return data
      }
      .mapError { error in
        if let error = error as? NetworkError {
          return error
        } else {
          return NetworkError.fetchError(reason: error.localizedDescription)
        }
      }
      .eraseToAnyPublisher()
  }
}
