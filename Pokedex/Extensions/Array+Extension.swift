import Foundation

extension Array where Element == Pokemon {
    
    static var test: [Pokemon] {
        return [
            Pokemon(id: 1, name: "Bulbasaur"),
            Pokemon(id: 4, name: "Charmander"),
            Pokemon(id: 7, name: "Squirtle")
        ]
    }
}
