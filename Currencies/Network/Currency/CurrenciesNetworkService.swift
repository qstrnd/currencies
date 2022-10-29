//
//  CurrenciesService.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Foundation
import Network

final class CurrenciesNetworkService {
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

    func getSymbols() async -> Result<SymbolsResponse, Error> {
        do {
            let symbolsResponse: SymbolsResponse = try await networkManager.perform(request: SymbolsRequest())
            return .success(symbolsResponse)
        } catch {
            return .failure(error)
        }
    }
}
