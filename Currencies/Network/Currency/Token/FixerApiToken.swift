//
//  FixerApiToken.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Foundation
import Network

struct FixerApiToken: Token {
    let apiKey: String

    func isValid() -> Bool {
        true
    }

    func stringValue() -> String {
        apiKey
    }
}
