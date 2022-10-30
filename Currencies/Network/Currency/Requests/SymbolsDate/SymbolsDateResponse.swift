//
//  SymbolsDateResponse.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import Foundation

struct SymbolsDateResponse: Decodable {
    let success: Bool
    let base: String

    let date: Date
    let historical: Bool?
    let timestamp: TimeInterval

    let rates: [String: Double]
}
