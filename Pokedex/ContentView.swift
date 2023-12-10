import SwiftUI

struct ContentView: View {
    
    @StateObject
    var pokemonStore = PokemonStore()
    
    @StateObject
    var favoritesStore = FavoritesStore()
    
    
    var body: some View {
        TabView {
            HomePage()
                .environmentObject(pokemonStore)
                .environmentObject(favoritesStore)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            LikedPage()
                .environmentObject(pokemonStore)
                .environmentObject(favoritesStore)
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
}

#Preview {
    ContentView()
}
