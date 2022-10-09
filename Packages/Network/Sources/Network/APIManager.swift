//
//  APIManager.swift
//  
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import Foundation

public protocol APIManager {
    func perform<T: Decodable>(request: Request) async throws -> T
}

public final class APIManagerImpl: APIManager {
    private let requestManager: RequestManager
    private let dataParser: DataParser

    public init(
        requestManager: RequestManager,
        dataParser: DataParser? = nil
    ) {
        self.requestManager = requestManager
        self.dataParser = dataParser ?? DefaultDataParser()
    }

    public func perform<T: Decodable>(request: Request) async throws -> T {
        let data = try await requestManager.perform(request: request)
        let model: T = try dataParser.decode(from: data)
        return model
    }
}
