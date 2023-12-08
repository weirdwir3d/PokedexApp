//
//  AbilityEntity.swift
//  PokedexApp721447
//
//  Created by opendag on 07/12/2023.
//

import Foundation

struct AbilityEntity: Codable {
    let ability: AbilityDetailEntity
}

struct AbilityDetailEntity: Codable {
    let name: String
    let url: String
}
