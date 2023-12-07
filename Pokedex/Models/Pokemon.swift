import Foundation

struct Pokemon: Identifiable {
    
    let id: Int
    let name: String
    
    var imageUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
    
    init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
        
//        init(id: Int, name: String, imageUrl: String, liked: Bool) {
//            self.id = id
//            self.name = name
//            self.imageUrl = imageUrl
//            self.liked = liked
//        }
    
}
