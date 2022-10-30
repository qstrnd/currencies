//
//  CurrencyBadge.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 21.10.2022.
//

import SwiftUI

struct CurrencyBadge: View {
    struct Model {
        let text: String
        let textColor: Color
        let backgroundColor: Color
    }

    @State var model: Model

    var body: some View {
        Text(model.text)
            .font(.headline)
            .foregroundColor(model.textColor)
            .padding(.vertical, 8)
            .frame(width: 52)
            .background(model.backgroundColor)
            .cornerRadius(8)
    }
}

struct CurrencyBadge_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyBadge(model: .init(text: "USD", textColor: .label, backgroundColor: .systemFill))
    }
}
