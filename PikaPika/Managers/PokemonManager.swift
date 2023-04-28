//
//  PokemonManager.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import Foundation


class PokemonManager {
    
    // call API-ul ca sa primim lista cu toti pokemoni
    func getPokemon(completion: @escaping ([Pokemon]) -> ()) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let pokemonList = try! JSONDecoder().decode(PokemonPage.self, from: data)
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }

    
    func fetchData(id: Int, completion: @escaping (DetailPokemon?, Error?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let session = URLSession.shared
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(DetailPokemon.self, from: data)
                print(jsonData)
            } catch let error {
                print("JSON decoding error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
