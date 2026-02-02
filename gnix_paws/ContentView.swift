//
//  ContentView.swift
//  gnix_paws
//
//  Created by Davi Gomes Florencio on 29/01/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query private var pets: [Pet]
  
  let layout = [GridItem(.flexible(minimum: 120)),
                GridItem(.flexible(minimum: 120))]
  
  @State private var path = [Pet]()
  @State private var isEditing: Bool = false
  
  func addPet() {
    isEditing = false
    let pet = Pet(name: "Best Friend")
    modelContext.insert(pet)
    path = [pet]
  }
  
  
  var body: some View {
    NavigationStack(path: $path){
      ScrollView{
        LazyVGrid(columns: layout){
          GridRow{
            ForEach(pets){ pet in
              NavigationLink(value: pet){
                VStack{
                  if let imageData = pet.photo{
                    if let image = UIImage(data: imageData){
                      Image(uiImage: image).resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(
                          cornerRadius: 8, style: .circular
                        ))                                        }
                  } else {
                    Image(systemName: "pawprint.circle")
                      .resizable()
                      .scaledToFit()
                      .padding(40)
                      .foregroundStyle(.quaternary)
                  }
                  
                  Spacer()
                  
                  Text(pet.name)
                    .font(.title.weight(.light))
                    .padding(.vertical)
                  
                  Spacer()
                }
                .frame(minWidth:0, maxWidth: .infinity,
                       minHeight: 0,maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: RoundedCornerStyle.circular))
                .overlay(alignment: .topTrailing) {
                  if isEditing {
                    Menu {
                      Button("Delete", systemImage: "trash", role: .destructive) {
                        withAnimation {
                          modelContext.delete(pet)
                          try? modelContext.save()
                        }
                      }
                    } label: {
                      Image(systemName: "trash.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.red)
                        .symbolRenderingMode(.multicolor)
                        .padding()
                    }
                  }
                }
              }
              .foregroundStyle(.primary)
            }
          }
        }
        .padding(.horizontal)
      }
      .navigationTitle(pets.isEmpty ? "No pets" : "My Pets")
      .navigationDestination(for: Pet.self, destination: EditPetView.init)
      .toolbar{
        ToolbarItem(placement: .topBarLeading) {
          Button {
            withAnimation {
              isEditing.toggle()
            }
          } label: {
            Image(systemName: "slider.horizontal.3")
          }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add a New Pet", systemImage: "plus.circle", action: addPet)
        }
      }
      .overlay{
        if pets.isEmpty {
          CustomUnavailableView(
            icon:"dog.circle",
            title: "No pets",
            description: "Add a new pet to see it here."
          )
        }
      }
    }
  }
}

#Preview("Sample Data") {
  ContentView()
    .modelContainer(Pet.preview)
}

#Preview("No Data") {
  ContentView()
    .modelContainer(for: Pet.self, inMemory: true)
}
