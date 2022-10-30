//
//  ConvertSymbolRequest.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import Foundation

struct ConvertSymbolRequest: FixerAPIRequest {
    let amount: Double
    let from: String
    let to: String
    let date: Date?

    var fixerPath = "convert"

    var queryParameters: [String : String] {
        var parameters = [
            "from": from,
            "to": to,
            "amount": "\(amount)"
        ]

        if let date = date {
            parameters["date"] = FixerApiDateFormatter.shared.string(from: date)
        }

        return parameters
    }
}
