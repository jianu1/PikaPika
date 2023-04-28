//
//  PokemonManager.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import Foundation


final class PokemonManager {
    
    let networkManager = NetworkManager()
    
    func getPokemon(completion: @escaping ([Pokemon]) -> ()) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/"
        networkManager.fetchData(urlString: urlString) { (result: Result<PokemonPage, APIError>) in
            switch result {
            case .success(let pokemonPage):
                DispatchQueue.main.async {
                    completion(pokemonPage.results)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchDetailedPokemon(id: Int, completion: @escaping (DetailPokemon?, Error?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        networkManager.fetchData(urlString: urlString) { (result: Result<DetailPokemon, APIError>) in
            switch result {
            case .success(let detailPokemon):
                DispatchQueue.main.async {
                    completion(detailPokemon, nil)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
}
