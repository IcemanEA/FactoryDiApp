//
//  NetworkErrors.swift
//  FamilyGoV3
//
//  Created by Egor Ledkov on 12.12.2022.
//

import Foundation

enum NetworkError: Error, LocalizedError {
  case unknown
  case noInitManager
  case badURL
  case noData
  case badEncode
  case badDecode(reason: String)
  case fetchError(reason: String)
  case badResponse(reason: String)
  
  var errorDescription: String? {
    switch self {
    case .unknown:
      return "Unknown error"
    case.noInitManager:
      return "NetworkManager didn't initialize"
    case .badURL:
      return "Bad URL address"
    case .noData:
      return "No data to display"
    case .badEncode:
      return "Bad Encode"
    case .badDecode(let reason):
      return "Bad Decode: \(reason)"
    case .fetchError(let reason):
      return "Fetch Error: \(reason)"
    case .badResponse(let reason):
      return "Internet Error: " + reason
    }
  }
}
