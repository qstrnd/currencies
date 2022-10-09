//
//  NetworkAPIManager.swift
//
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import Foundation

public protocol APIManager {
    func perform<T: Decodable>(request: Request) async throws -> T
}

public final class NetworkAPIManager<TStorage: TokenStorage>: APIManager {
    public typealias TokenRequestProvider = (() -> Request)

    private let requestManager: RequestManager
    private let dataParser: DataParser
    private let tokenStorage: TStorage?
    private let tokenRequestProvider: TokenRequestProvider?

    /// Initialize Network API manager
    /// - Parameters:
    ///   - requestManager: manages that request is fetched correctly
    ///   - dataParser: parses data to the concrete model type, pass `nil` for default parser
    ///   - tokenStorage: allows to store and retrieve the auth token, pass `nil` if no authorization is required
    ///   - tokenRequestProvider: a closure that requrns a concrete token request to fetch the token, pass `nil` if no authorization is required
    public init(
        requestManager: RequestManager,
        dataParser: DataParser? = nil,
        tokenStorage: TStorage? = nil,
        tokenRequestProvider: TokenRequestProvider?
    ) {
        self.requestManager = requestManager
        self.dataParser = dataParser ?? DefaultDataParser()
        self.tokenStorage = tokenStorage
        self.tokenRequestProvider = tokenRequestProvider
    }

    public func perform<T: Decodable>(request: Request) async throws -> T {
        var authToken: String?
        if request.addAuthorizationToken {
            authToken = try await getAuthToken()
        }

        let data = try await requestManager.perform(request: request, authToken: authToken)
        let model: T = try dataParser.decode(from: data)
        return model
    }

    private func getAuthToken() async throws -> String? {
        guard let tokenStorage else {
            preconditionFailure("Calling request that requires authorization without settting up a token storage")
        }
        guard let tokenRequestProvider else {
            preconditionFailure("Calling request that requires authorization without token request provider")
        }

        let token: TStorage.T
        if let storedToken = tokenStorage.getStoredToken(), storedToken.isValid() {
            token = storedToken
        } else {
            token = try await perform(request: tokenRequestProvider())
        }

        return token.stringValue()
    }
}
