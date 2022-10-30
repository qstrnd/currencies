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
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        let session = URLSession(configuration: configuration)

        let tokenConfiguration = TokenConfiguration(name: "apikey", location: .header)
        let urlRequestBuilder = DefaultURLRequestBuilder(tokenConfiguration: tokenConfiguration)

        let requestManager = DefaultRequestManager(session: session, urlRequestBuilder: urlRequestBuilder)


        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        let dataParser = DefaultDataParser(decoder: decoder)

        
        let fixerTokenStorage = FixerApiTokenStorage()


        networkManager = NetworkAPIManager(requestManager: requestManager, dataParser: dataParser, tokenStorage: fixerTokenStorage)
    }

    func getSymbols() async -> Result<SymbolsResponse, Error> {
        do {
            let response: SymbolsResponse = try await networkManager.perform(request: SymbolsRequest())
            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func getLatest(for base: String, symbols: [String]) async -> Result<LatestResponse, Error> {
        do {
            let response: LatestResponse = try await networkManager.perform(request: LatestRequest(base: base, symbols: symbols))
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
