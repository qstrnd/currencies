//
//  TokenStorage.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import Foundation

public protocol TokenStorage {
    associatedtype T: Token

    func getStoredToken() -> T?
    func save<T>(token: T)
}

public extension TokenStorage {
    func save<T>(token: T) {}
}

public class DefaultTokenStorage<T: Token>: TokenStorage {
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        userDefaults: UserDefaults = .standard,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }

    public func save<T>(token: T) {
        // simple encoder.encode(token) didn't work here despite Token conforming to codable
        guard let tokenEncodable = token as? Encodable,
              let encodedToken = try? encoder.encode(tokenEncodable) else {
            preconditionFailure("Encoder must be suitable for token encoding")
        }
        userDefaults.set(encodedToken, forKey: getStorageKey())
    }

    public func getStoredToken() -> T? {
        guard let encodedToken = userDefaults.value(forKey: getStorageKey()) as? Data else { return nil }
        guard let token = try? decoder.decode(T.self, from: encodedToken) else {
            preconditionFailure("Decoder must be suitable for token decoding")
        }
        return token
    }

    private func getStorageKey() -> String {
        "tech.yakovlev.network.\(String(describing: Token.self))"
    }
}
