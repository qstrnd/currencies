//
//  FixerAPIRequest.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Network

protocol FixerAPIRequest: Request {}

extension FixerAPIRequest {
    var host: String { "api.apilayer.com" }
    var requestType: RequestType { .get }
    var addAuthorizationToken: Bool { true }
}
