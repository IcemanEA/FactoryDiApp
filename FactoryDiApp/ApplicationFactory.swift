//
//  ApplicationFactory.swift
//  FactoryDiApp
//
//  Created by Egor Ledkov on 21.12.2022.
//

import SwiftUI

let viewFactory = ViewFactory()

// MARK: - ViewFactory
final class ViewFactory {
  
  fileprivate let applicationFactory = ApplicationFactory()
  fileprivate init() { }
  
  func makeLoginView() -> LoginView<LoginViewModel> {
    LoginView(viewModel: applicationFactory.loginViewModel)
  }
  
  func makeTabView() -> TabView<LoginViewModel> {
    TabView(viewModel: applicationFactory.tabViewModel)
  }
}


// MARK: - ApplicationFactory
final class ApplicationFactory {
  
  fileprivate let network: NetworkManager
  fileprivate let database: DatabaseManager
  
  fileprivate var loginViewModel: LoginViewModel {
    LoginViewModel(text: "login", network: network, database: database)
  }

  fileprivate var tabViewModel: LoginViewModel {
    LoginViewModel(text: "tab", network: network, database: database)
  }
  
  init() {
    network = NetworkManager()
    database = DatabaseManager.shared
  }
}
