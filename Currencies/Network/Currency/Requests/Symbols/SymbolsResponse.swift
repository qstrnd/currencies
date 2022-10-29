//
//  SymbolsResponse.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Foundation

struct SymbolsResponse: Decodable {
    let success: Bool
    let symbols: [String: String]
}
