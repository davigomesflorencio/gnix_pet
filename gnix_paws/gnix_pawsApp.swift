//
//  gnix_pawsApp.swift
//  gnix_paws
//
//  Created by Davi Gomes Florencio on 29/01/26.
//

import SwiftUI
import SwiftData

@main
struct gnix_pawsApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: Pet.self)
    }
  }
}
