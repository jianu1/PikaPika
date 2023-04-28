//
//  PokemonViewModel.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import Foundation
import SwiftUI

final class PokemonViewModel: ObservableObject {
    
    let pokemonManager = PokemonManager()
    
    @State var pokemonStripe = ""

    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchPokemon = ""
    
    var filteredPokemonList: [Pokemon] {
        return searchPokemon == "" ? pokemonList : pokemonList.filter({ $0.name.contains(searchPokemon.lowercased())})
    }
    
    func getPokemonList() {
        pokemonManager.getPokemon { pokemon in
            self.pokemonList = pokemon
        }
    }
    
    func getPokeomnIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) { return index + 1 }
        return 0
    }
    
    func getDetailedPokemon(pokemon: Pokemon) {
        let id = getPokeomnIndex(pokemon: pokemon)
        pokemonManager.fetchDetailedPokemon(id: id) { result, error in
            self.pokemonDetails = result
        }
    }
    
    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)
        return string
    }
}
