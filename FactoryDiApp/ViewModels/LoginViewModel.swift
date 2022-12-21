//
//  LoginViewModel.swift
//  FactoryDiApp
//
//  Created by Egor Ledkov on 21.12.2022.
//

import Foundation

protocol LoginViewModelProtocol: ObservableObject {
  var text: String { get set }
}

final class LoginViewModel: LoginViewModelProtocol {
    
  @Published var text = ""
    
  private let network: NetworkManager
  private let database: DatabaseManager
  
  init(text: String, network: NetworkManager, database: DatabaseManager) {
    self.network = network
    self.database = database
    
    self.text = text
  }
}
