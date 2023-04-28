//
//  Pokemon.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//
// https://pokeapi.co/api/v2/pokemon/

import Foundation

struct Pokemon: Decodable {
    var results: [PokemonEntry]
}

struct PokemonEntry: Decodable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
}

class PokemonAPI {
    
    func getData(completion: @escaping ([PokemonEntry]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }
}
