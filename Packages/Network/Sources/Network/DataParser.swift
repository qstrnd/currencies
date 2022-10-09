//
//  DataParser.swift
//  
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import Foundation

public protocol DataParser {
    func decode<T: Decodable>(from data: Data) throws -> T
}

final class DefaultDataParser: DataParser {
    private let decoder: JSONDecoder

    init() {
        self.decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func decode<T>(from data: Data) throws -> T where T : Decodable {
        try decoder.decode(T.self, from: data)
    }
}
