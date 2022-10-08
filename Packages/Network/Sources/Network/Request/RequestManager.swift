//
//  RequestManager.swift
//  
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import Foundation

public protocol RequestManager {
    func perform(request: Request) async throws -> Data
}

public final class DefaultRequestManager: RequestManager {
    private let session: URLSession
    private let urlRequestBuilder: URLRequestBuilder

    public init(
        session: URLSession = .shared,
        urlRequestBuilder: URLRequestBuilder? = nil
    ) {
        self.session = session
        self.urlRequestBuilder = urlRequestBuilder ?? DefaultURLRequestBuilder()
    }

    public func perform(request: Request) async throws -> Data {
        let urlRequest = try urlRequestBuilder.urlRequest(for: request)

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.InvalidResponse.other
        }

        let statusCode = httpResponse.statusCode
        guard statusCode == 200 else {
            if statusCode == 404 {
                throw NetworkError.InvalidResponse.notFound
            } else if statusCode >= 400 && statusCode < 500 {
                throw NetworkError.InvalidResponse.clientError
            } else if statusCode >= 500 {
                throw NetworkError.InvalidResponse.serverError
            } else {
                throw NetworkError.InvalidResponse.other
            }
        }

        return data
    }
}
