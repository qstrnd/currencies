//
//  LatestResponse.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 29.10.2022.
//

import Foundation

struct LatestResponse: Decodable {
    let base: String
    let date: Date
    let rates: [String: Double]
    let success: Bool
    let timestamp: TimeInterval
}
