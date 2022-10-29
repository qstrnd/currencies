//
//  SymbolsRequest.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Network

struct SymbolsRequest: FixerAPIRequest {
    let path = "fixer/symbols"
}
