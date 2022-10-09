//
//  APIManagerTests.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import XCTest
@testable import Network

final class APIManagerTests: XCTestCase {

    var defaults = UserDefaults(suiteName: #file)!
    var tokenStorage: DefaultTokenStorage<TestToken>!
    var sut: NetworkAPIManager<DefaultTokenStorage<TestToken>>!

    override func setUpWithError() throws {
        let requestManager = RequestManagerMock()
        let tokenRequestProvider = { RequestMock(path: "Token") }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)

        let dataParser = DefaultDataParser(decoder: decoder)

        tokenStorage = DefaultTokenStorage<TestToken>(userDefaults: defaults, encoder: encoder, decoder: decoder)
        sut = NetworkAPIManager(requestManager: requestManager, dataParser: dataParser, tokenStorage: tokenStorage, tokenRequestProvider: tokenRequestProvider)
    }

    override func tearDownWithError() throws {
        defaults.removePersistentDomain(forName: #file)
    }

    func testRequestCurrency() async throws {
        // given
        let request = RequestMock(path: "Currency")

        // when
        let currency: Currency = try await sut.perform(request: request)

        // then
        let currencyRate: Double = 141.61

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let currencyDate = dateFormatter.date(from: "2022-10-08")

        XCTAssertEqual(currency.date, currencyDate, "Date of decoded currency doesn't match")
        XCTAssertEqual(currency.rate, currencyRate, "Rate of decoded currency doesn't match")
    }

    func testTokenIsNotFetchedWhenAuthRequired() async throws {
        // given
        let request = RequestMock(path: "Currency", addAuthorizationToken: false)

        // when
        let _: Currency = try await sut.perform(request: request)

        // then
        let token = tokenStorage.getStoredToken()
        XCTAssertNil(token, "Token is fetched though authorization is not required")
    }

    func testTokenIsFetchedWhenAuthRequired() async throws {
        // given
        let request = RequestMock(path: "Currency", addAuthorizationToken: true)

        // when
        let _: Currency = try await sut.perform(request: request)

        // then
        let token = tokenStorage.getStoredToken()
        XCTAssertNotNil(token, "Token is not fetched for request that requires authorization")
    }

    func testInvalidTokenRefetched() async throws {
        // given
        let request = RequestMock(path: "Currency", addAuthorizationToken: true)
        let expiredToken = TestToken(value: "oldToken", expirationDate: .distantPast)
        tokenStorage.save(token: expiredToken)

        // when
        let _: Currency = try await sut.perform(request: request)

        // then
        let updatedToken = tokenStorage.getStoredToken()
        XCTAssertNotNil(updatedToken, "No token is stored after update")
        XCTAssertNotEqual(expiredToken.value, updatedToken?.value, "Token wasn't updated")
    }
}
