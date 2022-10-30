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

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(FixerApiDateFormatter.shared)

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

    func getLatest(request: LatestRequest) async -> Result<LatestResponse, Error> {
        do {
            return .success(try await networkManager.perform(request: request))
        } catch {
            return .failure(error)
        }
    }

    func getFluctuation(request: FluctuationRequest) async -> Result<FluctuationResponse, Error> {
        do {
            return .success(try await networkManager.perform(request: request))
        } catch {
            return .failure(error)
        }
    }

    func getTimeSeries(request: TimeSeriesRequest) async -> Result<TimeSeriesResponse, Error> {
        do {
            return .success(try await networkManager.perform(request: request))
        } catch {
            return .failure(error)
        }
    }

}
