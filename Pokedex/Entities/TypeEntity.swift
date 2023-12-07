//
//  TypeEntity.swift
//  PokedexApp721447
//
//  Created by opendag on 07/12/2023.
//

import Foundation

struct TypeEntity: Codable {
    let slot: Int
    let type: TypeDetailEntity
}

struct TypeDetailEntity: Codable {
    let name: String
    let url: String
}
