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
        let chart: CurrencyMiniChart.Model
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
                CurrencyMiniChart(model: model.chart)
                    .frame(width: 50, height: 24)
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
            chart: .init(color: .green, items: [
                .init(date: .now.addingTimeInterval(-(60*60*24*12)), price: 61.650009),
                .init(date: .now.addingTimeInterval(-(60*60*24*11)), price: 61.650373),
                .init(date: .now.addingTimeInterval(-(60*60*24*10)), price: 61.650373),
                .init(date: .now.addingTimeInterval(-(60*60*24*9)), price: 61.650172),
                .init(date: .now.addingTimeInterval(-(60*60*24*8)), price: 61.249927),
                .init(date: .now.addingTimeInterval(-(60*60*24*7)), price: 62.250018),
                .init(date: .now.addingTimeInterval(-(60*60*24*6)), price: 61.275022),
                .init(date: .now.addingTimeInterval(-(60*60*24*5)), price: 61.32499),
                .init(date: .now.addingTimeInterval(-(60*60*24*4)), price: 61.525038),
                .init(date: .now.addingTimeInterval(-(60*60*24*3)), price: 61.525038),
                .init(date: .now.addingTimeInterval(-(60*60*24*2)), price: 61.525038),
                .init(date: .now.addingTimeInterval(-(60*60*24*1)), price: 61.34),
                .init(date: .now, price: 61.4)
            ]),
            name: "Russian Ruble",
            value: "₽ 61,58",
            hasBottomSeparator: true
        ))
    }
}
