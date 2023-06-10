//
//  PokemonView.swift
//  Assignment3
//
//  Created by user240039 on 6/9/23.
//

import Foundation
import SwiftUI

struct PokemonView: View {
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    
    var body: some View {
        NavigationStack{
            List(pokemonViewModel.pokemonArray) { creature in
                LazyVStack {
                    NavigationLink {
                        PokemonDetailView(pokemon: creature)
                    } label: {
                        Text("\(creature.name)")
                    }
                }
                .onAppear() {
                    if let lastPoke = pokemonViewModel.pokemonArray.last {
                        if creature.id == lastPoke.id && pokemonViewModel.urlString.hasPrefix("https") {
                            Task {
                                await pokemonViewModel.getData()
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon List")
            .toolbar {
                ToolbarItem (id: UUID().uuidString, placement: .bottomBar, showsByDefault: true) {
                    Button("Load List") {
                        Task {
                            await pokemonViewModel.loadAll()
                        }
                    }
                    .buttonStyle(.bordered)
                }
                ToolbarItem (placement:.status) {
                    Text("\(pokemonViewModel.pokemonArray.count) of \(pokemonViewModel.count)")
                }
            }
            .task {
                await pokemonViewModel.getData()
            }
        }
    }
}
    
    
