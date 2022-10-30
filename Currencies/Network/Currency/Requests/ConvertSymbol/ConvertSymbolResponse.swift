//
//  ConvertSymbolResponse.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import Foundation

struct ConvertSymbolResponse: Decodable {
    let success: Bool

    let date: Date
    let historical: Bool?
    let result: Double

    let info: Info
    let query: Query

    struct Info: Decodable {
        let rate: Double
        let timestamp: TimeInterval
    }

    struct Query: Decodable {
        let amount: Double
        let from: String
        let to: String
    }
}
