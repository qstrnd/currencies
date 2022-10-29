//
//  CurrencyCell.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 21.10.2022.
//

import SwiftUI

struct CurrencyCell: View {
    let currencySymbol: String
    let currencyName: String
    let currencyValue: String

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            CurrencyView(text: currencySymbol)
            Text(currencyName)
            Spacer()
            Text(currencyValue)
        }
    }
}

struct CurrencyCell_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCell(currencySymbol: "GEL", currencyName: "Georgian Lari", currencyValue: "2,82")
    }
}
