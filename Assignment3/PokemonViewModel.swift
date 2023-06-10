//
//  PokemonViewModel.swift
//  Assignment3
//
//  Created by user240039 on 6/9/23.
//

import Foundation
import SwiftUI

@MainActor
class PokemonViewModel: ObservableObject {

    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Pokemon]
    }
    
    var count = 0
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    @Published var pokemonArray: [Pokemon] = []
    var isFetching = false
    
    func getData() async {
        guard urlString.hasPrefix("http") else {return}
        guard !isFetching else { return }
        isFetching = true
    
        guard let url = URL(string: urlString) else {
            isFetching = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let returned = try? JSONDecoder().decode(Returned.self, from: data) {
                self.count = returned.count
                self.urlString = returned.next ?? ""
                DispatchQueue.main.async {
                    self.pokemonArray = self.pokemonArray + returned.results
                }
                isFetching = false
            } else {
                isFetching = false
                print("Couldn't decode.")
            }
        } catch {
            isFetching = false
            print("Couldn't get URL from site \(urlString). \(error.localizedDescription)")
        }
    }
    
    func shouldLoad(index: Int) {
        if index == self.pokemonArray.count-1 && self.urlString.hasPrefix("http") {
            Task {
                await self.getData()
            }
        }
    }
    func loadAll() async {
        while self.urlString.hasPrefix("http") && !self.isFetching {
                await self.getData()
                await loadAll()
        }
    }
}
