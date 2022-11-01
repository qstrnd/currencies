//
//  DependencyResolver.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 31.10.2022.
//

import Foundation
import Network
import Swinject

final class DependencyResolver {

    // MARK: Internal

    enum Names: String {
        case fixerAPI
        case apiRequests
    }

    static let shared = DependencyResolver()

    func resolve<T>(_ type: T.Type, name: Names? = nil) -> T {
        if let name = name {
            return container.resolve(T.self, name: name.rawValue)!
        }
        return container.resolve(T.self)!
    }
    
    // MARK: Private

    private let container = Container()

    private init() {

        // MARK: General API

        container.register(URLSession.self, name: Names.apiRequests.rawValue) { _ in
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

            return URLSession(configuration: configuration)
        }
        .inObjectScope(.container)

        // MARK: Fixer API

        container.register(URLRequestBuilder.self, name: Names.fixerAPI.rawValue) { _ in
            let tokenConfiguration = TokenConfiguration(name: "apikey", location: .header)
            return DefaultURLRequestBuilder(tokenConfiguration: tokenConfiguration)
        }
        .inObjectScope(.container)

        container.register(RequestManager.self, name: Names.fixerAPI.rawValue) { resolver in
            DefaultRequestManager(
                session: resolver.resolve(URLSession.self, name: Names.apiRequests.rawValue)!,
                urlRequestBuilder: resolver.resolve(URLRequestBuilder.self, name: Names.fixerAPI.rawValue)
            )
        }
        .inObjectScope(.container)

        container.register(DataParser.self, name: Names.fixerAPI.rawValue) { _ in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(FixerApiDateFormatter.shared)

            return DefaultDataParser(decoder: decoder)
        }
        .inObjectScope(.container)

        container.register(CurrenciesNetworkService.self) { resolver in
            let apiManager = NetworkAPIManager(
                requestManager: resolver.resolve(RequestManager.self, name: Names.fixerAPI.rawValue)!,
                dataParser: resolver.resolve(DataParser.self, name: Names.fixerAPI.rawValue),
                tokenStorage: FixerApiTokenStorage()
            )
            return CurrenciesNetworkServiceImpl(networkManager: apiManager)
        }
        .inObjectScope(.container)

        // MARK: Other
    }
}
