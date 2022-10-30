//
//  TimeSeriesRequest.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import Foundation

struct TimeSeriesRequest: FixerAPIRequest {
    let base: String
    let symbols: [String]
    let startDate: Date
    let endDate: Date

    let fixerPath = "timeseries"

    var queryParameters: [String : String] {
        [
            "base": base,
            "symbols": symbols.joined(separator: ","),
            "start_date": FixerApiDateFormatter.shared.string(from: startDate),
            "end_date": FixerApiDateFormatter.shared.string(from: endDate)
        ]
    }
}
