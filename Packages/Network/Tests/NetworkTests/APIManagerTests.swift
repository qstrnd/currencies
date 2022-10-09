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
    var sut: NetworkAPIManager<DefaultTokenStorage<TokenMock>>!

    override func setUpWithError() throws {
        let requestManager = RequestManagerMock()
        let tokenStorage = DefaultTokenStorage<TokenMock>(userDefaults: defaults)
        let tokenRequestProvider = { RequestMock(path: "Mock") }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        let dataParser = DefaultDataParser(decoder: decoder)
        
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
}
