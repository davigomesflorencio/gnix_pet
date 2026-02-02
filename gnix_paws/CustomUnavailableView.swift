//
//  CustomUnavailableView.swift
//  gnix_paws
//
//  Created by Davi Gomes Florencio on 29/01/26.
//

import SwiftUI
import SwiftData

struct CustomUnavailableView: View {
  
  var icon:String
  var title:String
  var description:String
  
  var body: some View {
    ContentUnavailableView{
      Image(systemName: icon)
        .resizable()
        .scaledToFit()
        .frame(width: 96)
      
      Text(title)
        .font(.largeTitle)
        .bold()
      
    }description: {
      Text(description)
    }
    .foregroundStyle(.tertiary)
  }
}

#Preview {
  CustomUnavailableView(
    icon: "cat.circle", title: "No photo", description: "No photos available"
  )
}
