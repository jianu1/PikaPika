//
//  PokemonModel.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    var results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
}

struct PokemonSprites: Codable {
    var front_default: String?
}
