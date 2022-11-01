//
//  CurrenciesService.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Foundation
import Network

protocol CurrenciesNetworkService: AnyObject {
    func getSymbols() async -> Result<SymbolsResponse, Error>
    func getLatest(request: LatestRequest) async -> Result<LatestResponse, Error>
    func getFluctuation(request: FluctuationRequest) async -> Result<FluctuationResponse, Error>
    func getTimeSeries(request: TimeSeriesRequest) async -> Result<TimeSeriesResponse, Error>
    func getSymbolsDate(request: SymbolsDateRequest) async -> Result<SymbolsDateResponse, Error>
    func getConvertedSymbol(request: ConvertSymbolRequest) async -> Result<ConvertSymbolResponse, Error>
}

final class CurrenciesNetworkServiceImpl: CurrenciesNetworkService {
    private let networkManager: NetworkAPIManager<FixerApiTokenStorage>

    init(networkManager: NetworkAPIManager<FixerApiTokenStorage>) {
        self.networkManager = networkManager
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

    func getSymbolsDate(request: SymbolsDateRequest) async -> Result<SymbolsDateResponse, Error> {
        do {
            return .success(try await networkManager.perform(request: request))
        } catch {
            return .failure(error)
        }
    }

    func getConvertedSymbol(request: ConvertSymbolRequest) async -> Result<ConvertSymbolResponse, Error> {
        do {
            return .success(try await networkManager.perform(request: request))
        } catch {
            return .failure(error)
        }
    }

}
