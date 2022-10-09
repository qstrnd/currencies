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

public final class DefaultDataParser: DataParser {
    private let decoder: JSONDecoder

    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    public func decode<T>(from data: Data) throws -> T where T : Decodable {
        try decoder.decode(T.self, from: data)
    }
}
