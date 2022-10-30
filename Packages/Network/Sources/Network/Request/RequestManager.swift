//
//  RequestManager.swift
//  
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import Foundation
import OSLog

public protocol RequestManager {
    func perform(request: Request, authToken: String?) async throws -> Data
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

    public func perform(request: Request, authToken: String?) async throws -> Data {
        let urlRequest: URLRequest
        if let authToken {
            urlRequest = try urlRequestBuilder.urlRequest(for: request, authToken: authToken)
        } else {
            urlRequest = try urlRequestBuilder.urlRequest(for: request)
        }

        os_log(.info, log: .network, "Running request for url: \(urlRequest.url!.absoluteString)")

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            os_log(.debug, log: .network, "Request to \(request.path) failed with invalid response")
            throw NetworkError.InvalidResponse.other
        }

        let statusCode = httpResponse.statusCode
        guard statusCode == 200 else {
            os_log(.debug, log: .network, "Request to \(request.path) failed with status code: \(statusCode). Request: \(request.path)")

            switch statusCode {
            case 401:
                throw NetworkError.InvalidResponse.unauthorized
            case 404:
                throw NetworkError.InvalidResponse.notFound
            case 400 ..< 500:
                throw NetworkError.InvalidResponse.clientError
            case 500...:
                throw NetworkError.InvalidResponse.serverError
            default:
                throw NetworkError.InvalidResponse.other
            }
        }

        return data
    }
}
