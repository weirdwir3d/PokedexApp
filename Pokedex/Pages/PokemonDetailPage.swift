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
        var pokemonStore: PokemonStore
        
        @StateObject
        var detailStore = PokemonDetailStore()
        
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Color(Color.red)
                        .frame(maxHeight: 380)
                    Spacer()
                        .background(Color(Color.pink))
                }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack() {
                    HStack {
                        Text(pokemon.name)
                            .font(
                                Font.custom("Cabinet Grotesk Variable", size: 32)
                                    .weight(.heavy)
                            )
                            .multilineTextAlignment(.trailing)
                        
                        Spacer()
                        
//                        Text("#" + pokemon.id.formatPokedexNumber())
//                            .font(Font.custom("Cabinet Grotesk Variable", size: 24))
//                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                    
                    
                    if let details = detailStore.details {
                        switch details {
                        case .success(let details):
                            VStack {
                                AboutRow(label: "Name:", value: details.name.capitalized)
                                AboutRow(label: "ID:", value: String(details.id))
                                AboutRow(label: "Base:", value: details.baseExperience.formatted() + " XP")
                                AboutRow(label: "Weight:", value: details.weight.formatted() + " kg")
                                AboutRow(label: "Height:", value: details.height.formatted() + " m")
                                AboutRow(label: "Types:", value: details.types.map { $0.type.name.capitalized }.joined(separator: ", "))
                                AboutRow(label: "Abilities:", value: details.abilities.map { $0.ability.name.capitalized }.joined(separator: ", "))
                            }
                            .environmentObject(detailStore)
                        case .failure(let error):
                            Text("Something went wrong in the Pokemon Detils page: \(error.localizedDescription)")
                        }
                    } else {
                        ProgressView()
                    }
                    
                    Spacer()
                }
            }
        }
        .frame(alignment: .top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
            // Handle the heart icon tap action here
        }) {
//            if (liked) {
////                Button(action: {
////                    pokemonStore.unlikePokemon(id: pokemon.id)
////                    liked.toggle()
////                }) {
////                    Image(systemName: "heart.fill")
////                        .foregroundColor(.red)
////                }
//            } else {
////                Button(action: {
////                    liked.toggle()
////                    pokemonStore.likePokemon(id: pokemon.id)
////                }) {
////                    Image(systemName: "heart")
////                        .foregroundColor(.black)
////                }
//            }
            
        }
        )
        .task {
            await detailStore.fetchDetails(for: pokemon)
        }
    }
    
}



#Preview {
    NavigationView {
        PokemonDetailPage(pokemon: .test)
    }
}

struct AboutRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(
                    Font.custom("Rubik", size: 14)
                        .weight(.semibold)
                )
                .foregroundColor(Color(Color.green))
                .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
            
            Text(value)
                .font(Font.custom("Rubik", size: 14))
                .foregroundColor(Color(Color.green))
                .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
        }
        .padding(8)
    }
}
