import Foundation

struct Pokemon: Identifiable, Equatable {
    
    let id: Int
    let name: String
    
    var imageUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}
