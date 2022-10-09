//
//  Token.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import Foundation

public protocol Token: Decodable {
    func isValid() -> Bool
    func stringValue() -> String
}
