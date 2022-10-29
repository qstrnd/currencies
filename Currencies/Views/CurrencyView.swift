//
//  CurrencyView.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 21.10.2022.
//

import SwiftUI

struct CurrencyView: View {
    let text: String
    var textColor: Color = .white
    var color: Color = .accentColor

    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(textColor)
            .padding(.vertical, 8)
            .frame(width: 52)
            .background(color)
            .cornerRadius(8)
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(text: "USD")
    }
}
