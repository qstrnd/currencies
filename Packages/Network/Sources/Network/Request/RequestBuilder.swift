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

final class DefaultURLRequestBuilder: URLRequestBuilder {
    func urlRequest(for request: Request) throws -> URLRequest {
        precondition(!request.addAuthorizationToken, "Requests that require token auth must be called with urlRequest(for:authToken:)")
        return try urlRequest(for: request, authToken: "")
    }

    func urlRequest(for request: Request, authToken: String) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = request.host
        urlComponents.path = request.path

        urlComponents.queryItems = request.queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponents.url else { throw NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.requestType.value

        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !request.parameters.isEmpty {
            urlRequest.httpBody = try JSONEncoder().encode(request.parameters)
        }

        if request.addAuthorizationToken {
            urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }
}
