import Foundation

struct DetailResponseEntity: Codable {
    let abilities: [AbilityEntity]
    let base_experience: Int
    let height: Int
    let id: Int
    let types: [TypeEntity]
    let weight: Int
    
}


