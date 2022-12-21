//
//  DatabaseManager.swift
//  FamilyGoV3
//
//  Created by Egor Ledkov on 08.12.2022.
//
import Foundation
import GRDB

protocol DatabaseRecordProtocol: Identifiable, FetchableRecord, MutablePersistableRecord  {
  var id: Int64 { get set }
  func isEmptyRecord() -> String?
}

final class DatabaseManager {
  
  /// Provides a read-only access to the database
  var databaseReader: DatabaseReader {
    dbWriter
  }

  private let dbWriter: any DatabaseWriter

  private var migrator: DatabaseMigrator {
    createMigration()
  }
  
  /// Creates an `AppDatabase`, and make sure the database schema is ready.
  init(_ dbWriter: any DatabaseWriter) throws {
    self.dbWriter = dbWriter
    try migrator.migrate(dbWriter)
  }
}

// MARK: - Migration
extension DatabaseManager {
  private func createMigration() -> DatabaseMigrator {
    var migrator = DatabaseMigrator()
    
#if DEBUG
    migrator.eraseDatabaseOnSchemaChange = true
#endif
   
    migrator.registerMigration("v1") { db in
      
      // product
//      try db.create(table: MasterUserData.databaseTableName) { table in
//        table.autoIncrementedPrimaryKey("id")
//        table.column("login", .text).notNull()
//        table.column("pid", .integer)
//        table.column("system", .text)
//        table.column("language", .text)
//        table.column("counterLauncher", .integer).defaults(to: 0)
//      }
//

        
        
    }
    
    // Migrations for future application versions will be inserted here:
    // migrator.registerMigration(...) { db in
    //     ...
    // }
    
    return migrator
  }
}


// MARK: - CRUD methods
extension DatabaseManager {
  
  /// Saves (inserts or updates) a player. When the method returns, the
  /// record is present in the database, and its id is not nil.
  func save<T: DatabaseRecordProtocol>(_ record: inout T) throws {
    if let fields = record.isEmptyRecord() {
      throw DatabaseManager.DBError.missingFields(fields: fields)
    }
    try dbWriter.write { db in
      try record.save(db)
    }
  }
  
}
