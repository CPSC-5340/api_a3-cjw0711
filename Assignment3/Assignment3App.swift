//
// Assignment3App.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

@main
struct Assignment3App: App {
    @StateObject var pokemonViewModel = PokemonViewModel()
    
    var body: some Scene {
        WindowGroup {
            PokemonView()
                .environmentObject(PokemonViewModel())
        }
    }
}
