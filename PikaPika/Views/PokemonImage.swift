//
//  PokemonImage.swift
//  PikaPika
//
//  Created by Marius Stefanita Jianu on 28.04.2023.
//

import SwiftUI

struct PokemonImage: View {
    var imageLink = ""
    @State private var pokemonStripe = ""
    
    var body: some View {
        AsyncImage(url: URL(string: pokemonStripe))
            .frame(width: 75.0, height: 75.0)
            .onAppear {
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                
                if loadedData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                    print("New url!! Caching..")
                } else {
                    getSprite(url: loadedData!)
                    print("Using cached url..")
                }
            }
            .clipShape(Circle())
            .foregroundColor(Color.gray.opacity(0.60))
    }
    // facem apelul pentru API ca sa primim url-ul pentru imagine
    func getSprite(url:String) {
        var tempSprite: String?
        PokemonSelectedAPI().getData(url: url) { sprite in
            tempSprite = sprite.front_default
            self.pokemonStripe = tempSprite ?? "placeholder"
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
