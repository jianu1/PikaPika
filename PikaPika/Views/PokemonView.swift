//
//  PokemonView.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import SwiftUI

struct PokemonView: View {
    @EnvironmentObject var viewModel: PokemonViewModel
    let pokemon: Pokemon
    let dimensions: Double
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(viewModel.getPokeomnIndex(pokemon: pokemon)).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: dimensions, height: dimensions)
            } placeholder: {
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
                    
            }
            .background(.thinMaterial)
            .clipShape(Circle())
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemon: Pokemon.samplePokemon, dimensions: 0.0)
            .environmentObject(PokemonViewModel())
    }
}
