//
//  ContentView.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = PokemonViewModel()

    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.filteredPokemonList) { pokemon in
                    HStack {
                        NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                            HStack {
                                PokemonView(pokemon: pokemon, dimensions: 75.0)
                                Text(pokemon.name)
                            }
                        }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.filteredPokemonList.count)
            .navigationTitle("Pokemon List")
            .searchable(text: $viewModel.searchPokemon)
        }
        .onAppear {
            viewModel.getPokemonList()
        }
        .environmentObject(viewModel)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
