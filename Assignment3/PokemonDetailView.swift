//
//  PokemonDetailView.swift
//  Assignment3
//
//  Created by user240039 on 6/9/23.
//

import Foundation
import SwiftUI

struct PokemonDetailView: View {
    @State var pokemon: Pokemon
    @StateObject var pokemonDetail = PokemonDetail()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 3) {
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
                .bold()
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.bottom)
            HStack {
                
                AsyncImage(url: URL(string: pokemonDetail.imageURL)){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(radius: 8, x: 5, y: 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                        .padding()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, maxHeight: 96)
                }

                VStack(alignment: .leading) {
                    HStack (alignment: .top) {
                        Text("Height:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                            .fixedSize()
                        VStack (alignment: .trailing) {
                            Text(String(format: "%.1f", pokemonDetail.height))
                                .font(.largeTitle)
                                .bold()
                                .fixedSize()
                        }
                    }
                    .padding(.bottom, 3)
                    HStack (alignment: .top) {
                        Text("Weight:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                            .fixedSize()
                        Text(String(format: "%.1f", pokemonDetail.weight))
                            .font(.largeTitle)
                            .bold()
                            .fixedSize()
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .task {
            pokemonDetail.urlString = pokemon.url
            await pokemonDetail.getData()
        }
        Spacer()
            .navigationBarTitleDisplayMode(.inline)
    }
}

