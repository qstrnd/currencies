//
//  LatestResponse.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Foundation

struct LatestResponse: Decodable {
    let success: Bool
    let base: String
    let date: Date
    let timestamp: TimeInterval
    let rates: [String: Double]
}
