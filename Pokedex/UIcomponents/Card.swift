//
//  Card.swift
//  PokedexApp721447
//
//  Created by opendag on 05/12/2023.
//

import SwiftUI

struct Card: View {
    var pokemon: Pokemon
    
    var body: some View {
        NavigationLink(
            destination: {
                PokemonDetailPage(
                    pokemon: pokemon
                )
            },
            label: {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0)
                    .frame(width: 150, height: 170)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "#e3e6fa")) // Set the background color here
                    )
                    .overlay(
                        VStack(spacing: 0) {
                            idBadge(pokemon: pokemon)
                                .padding(.leading, -70) 
                            // First Rectangle with AsyncImage
                            AsyncImage(
                                url: pokemon.imageUrl, // Replace with your image URL
                                content: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 120)
                                        .cornerRadius(10)
                                },
                                placeholder: {
                                    Color(hex: "#e3e6fa") // Placeholder color
                                }
                            )
                            
                            // Second Rectangle with Text
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(height: 25)
                                .overlay(
                                    Text(pokemon.name)
                                        .foregroundColor(.black)
                                )
                        }
                    )
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 2, y: 2)
            }
        )
    }
}


#Preview {
    Card(pokemon: Pokemon(id: 5, name: "Pikachu"))
}
