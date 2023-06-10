//
//  Pokemon.swift
//  Assignment3
//
//  Created by user240039 on 6/9/23.
//

import Foundation
import SwiftUI

struct Pokemon: Hashable, Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String

    private enum CodingKeys: String, CodingKey {
        case name, url
    }
}
