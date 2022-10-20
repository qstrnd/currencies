//
//  TokenConfiguration.swift
//  
//
//  Created by Andrey Yakovlev on 20.10.2022.
//

import Foundation

public struct TokenConfiguration {
    public let name: String
    public let location: RequestLocation

    public enum RequestLocation {
        case query
        case header
    }
}

extension TokenConfiguration {
    static let `default` = TokenConfiguration(name: "Authorization", location: .header)
}
