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

/*
 {
   "base": "RUB",
   "end_date": "2022-02-24",
   "fluctuation": true,
   "rates": {
     "EUR": {
       "change": -0.0039,
       "change_pct": -27.0711,
       "end_rate": 0.01052,
       "start_rate": 0.014425
     }
   },
   "start_date": "2018-02-24",
   "success": true
 }
 */
