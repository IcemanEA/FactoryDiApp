//
//  DatabaseError.swift
//  FamilyGoV3
//
//  Created by Egor Ledkov on 15.12.2022.
//

import Foundation

extension DatabaseManager {
  enum DBError: Error, LocalizedError {
    case noData
    case noInitManager
    case missingFields(fields: String)
    case canNotFetch(reason: String)
    
    var errorDescription: String? {
      switch self {
      case .noData:
        return "No data fetched"
      case .noInitManager:
        return "Database Manager didn't initialize"
      case .missingFields(let fields):
        return "Please provide a \(fields)"
      case .canNotFetch(let reason):
        return "Can not fetch data from \(reason)"
      }
    }
  }
}
