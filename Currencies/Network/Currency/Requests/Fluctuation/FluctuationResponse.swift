//
//  FluctuationResponse.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import Foundation

struct FluctuationResponse: Decodable {
    let success: Bool
    let base: String
    
    let startDate: Date
    let endDate: Date

    let fluctuation: Bool
    let rates: [String: Rate]

    struct Rate: Decodable {
        let change: Double
        let changePct: Double
        let endRate: Double
        let startRate: Double
    }
}
