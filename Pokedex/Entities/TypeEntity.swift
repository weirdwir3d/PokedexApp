import Foundation

struct TypeEntity: Codable {
    let slot: Int
    let type: TypeDetailEntity
}

struct TypeDetailEntity: Codable {
    let name: String
    let url: String
}
