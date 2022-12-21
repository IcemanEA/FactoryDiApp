//
//  LoginView.swift
//  FactoryDiApp
//
//  Created by Egor Ledkov on 21.12.2022.
//

import SwiftUI

struct LoginView<ViewModel>: View where ViewModel: LoginViewModelProtocol {
  @ObservedObject var viewModel: ViewModel
  
  var body: some View {
    VStack {
      Text(viewModel.text)
      TextField("Text", text: $viewModel.text)
        .textFieldStyle(.roundedBorder)
    }
    .padding()
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView<FakeLoginViewModel>(viewModel: FakeLoginViewModel())
  }
}
