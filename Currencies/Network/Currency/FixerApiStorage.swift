//
//  FixerApiStorage.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Foundation
import Network

final class FixerApiTokenStorage: TokenStorage {
    let environment: AppEnvironment = .current

    func getStoredToken() -> FixerApiToken? {
        FixerApiToken(apiKey: environment.fixerAPIKey)
    }

    func save(token: FixerApiToken) {}
}
