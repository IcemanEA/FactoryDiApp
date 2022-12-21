//
//  FakeLoginViewModel.swift
//  FactoryDiApp
//
//  Created by Egor Ledkov on 21.12.2022.
//

import Foundation

final class FakeLoginViewModel: LoginViewModelProtocol {
  var text: String
  
  init() {
    text = "456"
  }
}
