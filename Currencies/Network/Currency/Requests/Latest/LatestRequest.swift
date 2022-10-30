//
//  LatestRequest.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Network

struct LatestRequest: FixerAPIRequest {
    let base: String
    let symbols: [String]

    let fixerPath = "latest"

    var queryParameters: [String : String] {
        [
            "base": base,
            "symbols": symbols.joined(separator: ",")
        ]
    }
}
