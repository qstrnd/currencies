//
//  TokenStorage.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import UIKit

public protocol TokenStorage {
    associatedtype T: Token

    func getStoredToken() -> T?
    func save<T>(token: T)
}

public class DefaultTokenStorage<T: Token>: TokenStorage {
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func save<T>(token: T) {
        userDefaults.set(token, forKey: getStorageKey())
    }

    public func getStoredToken() -> T? {
        userDefaults.value(forKey: getStorageKey()) as? T
    }

    private func getStorageKey() -> String {
        "tech.yakovlev.network.\(String(describing: Token.self))"
    }
}
