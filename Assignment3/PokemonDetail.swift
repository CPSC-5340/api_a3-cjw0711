//
//  PokemonDetail.swift
//  Assignment3
//
//  Created by user240039 on 6/9/23.
//

import Foundation
import SwiftUI

@MainActor
class PokemonDetail: ObservableObject {
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprites
    }
    
    private struct Sprites: Codable {
        var front_default: String?
    }
    
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageURL = ""
    @Published var urlString = ""
    
    func getData() async {
        guard let url = URL(string: urlString) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let returned = try? JSONDecoder().decode(Returned.self, from: data) {
                self.height = returned.height
                self.weight = returned.weight
                self.imageURL = returned.sprites.front_default ?? ""
                print("Height: \(self.height), Weight: \(self.weight), URL: \(self.imageURL)")
            } else {
                print("Couldn't decode returned data.")
            }
        } catch {
            print("Couldn't obtain URL from data at \(urlString). \(error.localizedDescription)")
        }
    }
}
