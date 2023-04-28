//
//  PokemonDetailsView.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    @EnvironmentObject var viewModel: PokemonViewModel
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            // Pokemon View
            PokemonView(pokemon: pokemon, dimensions: 200.0)
            
            VStack(spacing: 10.0) {
                Text("ID: \(viewModel.pokemonDetails?.id ?? 0)")
                Text("Weight: \(viewModel.formatHW(value: viewModel.pokemonDetails?.weight ?? 0)) KG")
                Text("Height: \(viewModel.formatHW(value: viewModel.pokemonDetails?.weight ?? 0)) M")
            }
        }
        .onAppear {
            viewModel.getDetaidPokemon(pokemon: pokemon)
        }
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(pokemon: .samplePokemon).environmentObject(PokemonViewModel())
    }
}
