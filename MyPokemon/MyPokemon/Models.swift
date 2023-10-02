//
//  Models.swift
//  MyPokemon
//
//  Created by Karim Arhan on 29/09/23.
//

import Foundation

struct Pokemon: Decodable {
  let count: Int
  let next: String
  let results: [PokemonList]
}

struct PokemonList: Decodable {
    let name: String
    let url: String
}

struct PokemonDetails: Decodable {
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let types: [PokemonTypes]
}

struct PokemonSprites: Decodable {
    let front_default: String
}

struct PokemonTypes: Decodable {
    let type: Types
}

struct Types: Decodable {
    let name: String
}
