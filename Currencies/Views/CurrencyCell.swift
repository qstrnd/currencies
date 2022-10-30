//
//  CurrencyCell.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 21.10.2022.
//

import SwiftUI

struct CurrencyCell: View {
    struct Model {
        let badge: CurrencyBadge.Model
        let name: String
        let value: String
        let hasBottomSeparator: Bool
    }

    @State var model: Model

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                CurrencyBadge(model: model.badge)
                Text(model.name)
                Spacer()
                Text(model.value)
                    .bold()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)


            if model.hasBottomSeparator {
                Divider()
                    .padding(.leading, 16)
            }
        }
    }
}

struct CurrencyCell_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCell(model: .init(
            badge: CurrencyBadge.Model(text: "RUB", textColor: .label, backgroundColor: .systemFill),
            name: "Russian Ruble",
            value: "₽ 61,58",
            hasBottomSeparator: true
        ))
    }
}
