import SwiftUI

struct idBadge: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .stroke(Color(hex: "#5631e8"), lineWidth: 1)
            .frame(width: 30, height: 14)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(hex: "#5631e8")) // Set the background color here
            )
            .padding(10)
        
            .overlay(
                Text(String(pokemon.id))
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .bold))
                
            )
    }
}

#Preview {
    idBadge(pokemon: Pokemon(id: 5, name: "Pikachu"))
}
