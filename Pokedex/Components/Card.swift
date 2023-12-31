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
                    .frame(width: 150, height: 195)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "#edeffa"))
                    )
                    .overlay(
                        VStack(spacing: 0) {
                            idBadge(pokemon: pokemon)
                                .padding(.leading, -70)
                            AsyncImage(
                                url: pokemon.imageUrl,
                                content: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 125)
                                        .cornerRadius(10)
                                },
                                placeholder: {
                                    Color(hex: "#5c5c5c")
                                }
                            )

                            Rectangle()
                                .foregroundColor(.white)
                                .opacity(0)
                                .cornerRadius(10)
                                .frame(height: 40)
                                .overlay(
                                    Text(pokemon.name)
                                        .foregroundColor(.black)
                                        .bold()
                                        
                                )
                        }
                    )
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 2, y: 2)
            }
        )
    }
}


#Preview {
    Card(pokemon: Pokemon(id: 6, name: "Pikachu"))
}
