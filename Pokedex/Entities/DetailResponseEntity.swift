// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let detailResponse = try? JSONDecoder().decode(DetailResponse.self, from: jsonData)

import Foundation

// MARK: - DetailResponse
struct DetailResponseEntity: Codable {
    let abilities: [AbilityEntity]
    let base_experience: Int
    let height: Int
    let id: Int
    let types: [TypeEntity]
    let weight: Int
    
}


