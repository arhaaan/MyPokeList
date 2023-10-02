//
//  PokemonManager.swift
//  MyPokemon
//
//  Created by Karim Arhan on 02/10/23.
//

import Foundation

let ThePokemonManager = PokemonManager.sharedInstance

class PokemonManager{
    static let sharedInstance = PokemonManager()
    
    var capturedPokemon = [PokemonList]()
}
