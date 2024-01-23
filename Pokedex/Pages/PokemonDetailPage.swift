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
                                }
                                
                            }
                            
                            HStack {
                                Text("Name")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
                                Text(pokemon.name.capitalized)
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
                            }
                            .padding(8)
                            
                            HStack {
                                Text("ID")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
                                Text(String(pokemon.id))
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
                            }
                            .padding(8)
                            
                            HStack {
                                Text("Base Experience")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
                                Text(details.baseExp.formatted() + " XP")
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
                            }
                            .padding(8)
                            
                            HStack {
                                Text("Weight")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
                                Text(details.weight.formatted() + " kg")
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
                            }
                            .padding(8)
                            
                            HStack {
                                Text("Height")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
                                Text(details.height.formatted() + " m")
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
                            }
                            .padding(8)
                            
                            HStack {
                                Text("Types")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
                                Text(details.types.map { $0.name.capitalized.localized }.joined(separator: ", "))
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
                            }
                            .padding(8)
                            
                            HStack {
                                Text("Abilities")
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity * 0.3, alignment: .topLeading)
                                Text(details.abilities.map { $0.name.capitalized }.joined(separator: ", "))
                                    .font(.system(size: 18))
                                    .frame(maxWidth: .infinity * 0.7, alignment: .topLeading)
                            }
                            .padding(8)
                            
                        }
                        .padding()
                        .environmentObject(detailStore)
                    case .failure(let error):
                        Text("Something went wrong: \(error.localizedDescription)")
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
