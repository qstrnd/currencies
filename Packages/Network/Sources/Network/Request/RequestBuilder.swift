//
//  RequestBuilder.swift
//  
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import Foundation

public protocol URLRequestBuilder {
    func urlRequest(for request: Request) throws -> URLRequest
    func urlRequest(for request: Request, authToken: String) throws -> URLRequest
}

public final class DefaultURLRequestBuilder: URLRequestBuilder {
    var tokenConfiguration: TokenConfiguration

    public init(tokenConfiguration: TokenConfiguration = .default) {
        self.tokenConfiguration = tokenConfiguration
    }

    public func urlRequest(for request: Request) throws -> URLRequest {
        precondition(!request.addAuthorizationToken, "Requests that require token auth must be called with urlRequest(for:authToken:)")
        return try urlRequest(for: request, authToken: "")
    }

    public func urlRequest(for request: Request, authToken: String) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = request.host
        urlComponents.path = "/\(request.path)"

        urlComponents.queryItems = request.queryParameters.isEmpty ? nil : request.queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponents.url else { throw NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.requestType.value

        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !request.parameters.isEmpty {
            urlRequest.httpBody = try JSONEncoder().encode(request.parameters)
        }

        if request.addAuthorizationToken {
            switch tokenConfiguration.location {
            case .header:
                urlRequest.setValue(authToken, forHTTPHeaderField: tokenConfiguration.name)
            case .query:
                urlRequest.url?.appendQueryItem(name: tokenConfiguration.name, value: authToken)
            }
        }

        return urlRequest
    }
}
