//
//  ContentView.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import SwiftUI

struct ContentView: View {

    @State var pokemon = [PokemonEntry]()
    @State var searchPokemon = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchPokemon == "" ? pokemon : pokemon.filter({ $0.name.contains(searchPokemon.lowercased()) })) { entry in
                    // Used LazyHstack ca sa nu incarc view tot odata, si doar atunci cand se face scroll sa se incarce restul de pokemoni
                    LazyHStack {
                        PokemonImage(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        NavigationLink("\(entry.name)".capitalized, destination: Text("Detail view for \(entry.name)"))
                    }
                }
            }
            .onAppear {
                PokemonAPI().getData { pokemon in
                    self.pokemon = pokemon
                    
                    for poke in pokemon {
                        print(poke)
                    }
                }
            }
            .searchable(text: $searchPokemon)
            .navigationTitle("PikaPika")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
