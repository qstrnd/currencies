//
//  RequestBuilderTests.swift
//  
//
//  Created by Andrey Yakovlev on 20.10.2022.
//

import XCTest
@testable import Network

final class RequestBuilderTests: XCTestCase {

    var sut: URLRequestBuilder!

    func testAuthIsAddedAsQueryParameter() throws {
        // given
        let host = "host"
        let path = "currency"
        let authQuery = "authQuery"
        let authToken = "authToken"

        sut = DefaultURLRequestBuilder(tokenConfiguration: .init(name: authQuery, location: .query))
        let request = RequestMock(host: host, path: path, requestType: .get, addAuthorizationToken: true)

        // when
        let urlRequest = try sut.urlRequest(for: request, authToken: authToken)

        // then
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://\(host)/\(path)?\(authQuery)=\(authToken)")
    }

    func testAuthIsAddedAsHeader() throws {
        // given
        let host = "host"
        let path = "currency"
        let authName = "authName"
        let authToken = "authToken"

        sut = DefaultURLRequestBuilder(tokenConfiguration: .init(name: authName, location: .header))
        let request = RequestMock(host: host, path: path, requestType: .get, addAuthorizationToken: true)

        // when
        let urlRequest = try sut.urlRequest(for: request, authToken: authToken)

        // then
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://\(host)/\(path)")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?.first?.key, authName)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?.first?.value, authToken)
    }

}
