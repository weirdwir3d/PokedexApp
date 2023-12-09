import SwiftUI

struct TypeBadge: View {
    
    let type: String
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 30)
            .stroke(selectBgColor(type: type), lineWidth: 1)
            .frame(width: 90, height: 30)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(selectBgColor(type: type)) 
            )
            .padding(2)
        
            .overlay(
                Text(type.localized)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                
            )
    }
}


func selectBgColor(type: String) -> Color {
    
    var hex: String
    
    switch type {
    case "Normal":
        hex = "#A8A77A"
    case "Fire":
        hex = "#EE8130"
    case "Water":
        hex = "#6390F0"
    case "Electric":
        hex = "#F7D02C"
    case "Grass":
        hex = "#7AC74C"
    case "Ice":
        hex = "#96D9D6"
    case "Fighting":
        hex = "#C22E28"
    case "Poison":
        hex = "#A33EA1"
    case "Ground":
        hex = "#E2BF65"
    case "Flying":
        hex = "#A98FF3"
    case "Psychic":
        hex = "#F95587"
    case "Bug":
        hex = "#A6B91A"
    case "Rock":
        hex = "#B6A136"
    case "Ghost":
        hex = "#735797"
    case "Dragon":
        hex = "#6F35FC"
    case "Dark":
        hex = "#705746"
    case "Steel":
        hex = "#B7B7CE"
    case "Fairy":
        hex = "#D685AD"
    default:
        hex = "#000000"
    }
    return Color(hex: hex)
}

#Preview {
    TypeBadge(type: "Electric")
}
