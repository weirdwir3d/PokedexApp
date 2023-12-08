//
//  PokemonDetailPage.swift
//  student721009
//
//  Created by hohe on 13.10.23.
//

import Foundation
import SwiftUI

struct PokemonDetailPage: View {
    
    let pokemon: Pokemon
    
    @EnvironmentObject
    var favoritesStore: FavoritesStore
    
    @EnvironmentObject
    var pokemonStore: PokemonStore
    
    @StateObject
    var detailStore = PokemonDetailStore()
    
    
    var body: some View {
        
        ScrollView{
                VStack {
                    HStack {
                        Text(pokemon.name)
                            .font(.system(size: 34))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.trailing)
                        
                        Spacer()
                        
                        Text("#" + String(pokemon.id))
                            .font(.system(size: 30))
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                    
                    
                    if let details = detailStore.details {
                        switch details {
                        case .success(let details):
                            VStack {
                                
                                HStack{
                                    ForEach(details.types, id: \.self) { type in
                                        TypeBadge(type: type.name.capitalized)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, -32)
                                
                                
                                AsyncImage(
                                    url: pokemon.imageUrl,
                                    content: { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 300, height: 300)
                                        //                                            .cornerRadius(10)
                                    },
                                    placeholder: {
                                        Color(hex: "#5c5c5c")
                                    }
                                )
                                .toolbar {
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button(action: { favoritesStore.toggle(for: pokemon) }) {
                                            let isFavorite = favoritesStore.isFavorite(pokemon)
                                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        }
                                    }
                                    
                                    ToolbarItem(placement: .topBarTrailing) {
                                            Button(action: {
                                                let pokemonImg = pokemon.imageUrl

                                                let activityViewController = UIActivityViewController(
                                                    activityItems: [pokemonImg],
                                                    applicationActivities: nil
                                                )

                                                UIApplication.shared.windows.first?.rootViewController?.present(
                                                    activityViewController,
                                                    animated: true,
                                                    completion: nil
                                                )
                                            }) {
                                                Image(systemName: "square.and.arrow.up")
                                            }
                                            .tint(Color.black)
                                        }
                                    
                                }
                                
                                AboutRow(label: "Name:", value: pokemon.name.capitalized)
                                AboutRow(label: "ID:", value: String(pokemon.id))
                                AboutRow(label: "Base:", value: details.baseExp.formatted() + " XP")
                                AboutRow(label: "Weight:", value: details.weight.formatted() + " kg")
                                AboutRow(label: "Height:", value: details.height.formatted() + " m")
                                AboutRow(label: "Types:", value: details.types.map { $0.name.capitalized }.joined(separator: ", "))
                                AboutRow(label: "Abilities:", value: details.abilities.map { $0.name.capitalized }.joined(separator: ", "))
                                Text("This text is only here to make the page bigger and show that it is actually scrollable and you would be able to see all details also on smaller phones with smaller screens ")
                            }
                            .padding()
                            .environmentObject(detailStore)
                        case .failure(let error):
                            Text("Something went wrong in the Pokemon Detils page: \(error.localizedDescription)")
                                .padding(16)
                            Button("Retry", action: {
                                Task {
                                    detailStore.details = nil
                                    await detailStore.fetchDetails(for: pokemon)
                                }
                            })
                            
                        }
                    } else {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                
            }
            .frame(alignment: .top)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await detailStore.fetchDetails(for: pokemon)
            }
        }
        
    
    
    
}



#Preview {
    NavigationView {
        PokemonDetailPage(pokemon: .test)
    }
    .environmentObject(FavoritesStore())
}

struct AboutRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 20))
                .fontWeight(.semibold)
            
            //                .foregroundColor(Color(Color.black))
                .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
            
            Text(value)
                .font(.system(size: 18))
            //                .foregroundColor(Color(Color.black))
                .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
        }
        .padding(8)
    }
}
