//
//  SymbolsDateRequest.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import Foundation

struct SymbolsDateRequest: FixerAPIRequest {
    let base: String
    let symbols: [String]
    let date: Date

    var fixerPath: String {
        FixerApiDateFormatter.shared.string(from: date)
    }

    var queryParameters: [String : String] {
        [
            "base": base,
            "symbols": symbols.joined(separator: ",")
        ]
    }
}
