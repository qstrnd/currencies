//
//  FixerApiDateFormatter.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import Foundation

enum FixerApiDateFormatter {
    static let shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
