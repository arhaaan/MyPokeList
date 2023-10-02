//
//  Fetcher.swift
//  MyPokemon
//
//  Created by Karim Arhan on 29/09/23.
//

import Foundation

extension URLSession {
    
  func getPokemons(at url: URL, completion: @escaping (Result<Pokemon, Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let toDos = try JSONDecoder().decode(Pokemon.self, from: data)
          completion(.success(toDos))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
    
    func getPokemonDetails(at url: URL, completion: @escaping (Result<PokemonDetails, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
          if let error = error {
            completion(.failure(error))
          }

          if let data = data {
            do {
              let toDos = try JSONDecoder().decode(PokemonDetails.self, from: data)
              completion(.success(toDos))
            } catch let decoderError {
              completion(.failure(decoderError))
            }
          }
        }.resume()
      }
}
