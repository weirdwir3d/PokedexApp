import SwiftUI

struct ContentView: View {
    
    @StateObject
    var pokemonStore = PokemonStore()
    
    
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            LikedPage()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
        .environmentObject(pokemonStore)
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
}

#Preview {
    ContentView()
        .environmentObject(PokemonStore())
}
