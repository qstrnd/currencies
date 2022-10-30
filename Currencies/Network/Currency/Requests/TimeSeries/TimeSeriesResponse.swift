//
//  TimeSeriesResponse.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import Foundation

struct TimeSeriesResponse: Decodable {
    let success: Bool
    let base: String

    let startDate: Date
    let endDate: Date

    let rates: [String: RateDictionary]

    typealias RateDictionary = [String: Double]
}
