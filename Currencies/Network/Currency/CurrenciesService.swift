//
//  CurrenciesService.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Foundation
import Network

final class CurrenciesService {
    let networkManager: NetworkAPIManager<FixerApiTokenStorage>

    init() {
        let fixerTokenStorage = FixerApiTokenStorage()

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        let session = URLSession(configuration: configuration)

        let tokenConfiguration = TokenConfiguration(name: "apikey", location: .header)
        let urlRequestBuilder = DefaultURLRequestBuilder(tokenConfiguration: tokenConfiguration)

        let requestManager = DefaultRequestManager(session: session, urlRequestBuilder: urlRequestBuilder)

        networkManager = NetworkAPIManager(requestManager: requestManager, tokenStorage: fixerTokenStorage)
    }

    struct SymbolResponse: Decodable {
        let success: Bool
        let symbols: [String: String]
    }

    struct SymbolRequest: Request {
        let host = "api.apilayer.com"
        let path = "fixer/symbols"
        let requestType: RequestType = .get
        let addAuthorizationToken = true
    }

    func getSymbols() async -> Result<SymbolResponse, Error> {
        do {
            let symbolResponse: SymbolResponse = try await networkManager.perform(request: SymbolRequest())
            return .success(symbolResponse)
        } catch {
            return .failure(error)
        }
    }
}
