//
//  TestToken.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import Foundation
import Network

struct TestToken: Token {
    let value: String
    var expirationDate: Date

    func stringValue() -> String {
        value
    }

    func isValid() -> Bool {
        expirationDate > .now
    }
}
