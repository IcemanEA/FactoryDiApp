//
//  ContentView.swift
//  FactoryDiApp
//
//  Created by Egor Ledkov on 20.12.2022.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack(spacing: 50) {
        NavigationLink("Show Login View", destination: viewFactory.makeLoginView)
        NavigationLink("Show Tab View", destination: viewFactory.makeTabView)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
