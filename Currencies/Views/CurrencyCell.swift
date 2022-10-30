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
        let chart: CurrencyMiniChart.Model?
        let name: String
        let value: String?
        let hasBottomSeparator: Bool
    }

    @State var model: Model

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                CurrencyBadge(model: model.badge)
                Text(model.name)
                Spacer()
                if let chart = model.chart {
                    CurrencyMiniChart(model: chart)
                        .frame(width: 40, height: 24)
                        .clipped()
                }
                if let value = model.value {
                    Text(value)
                        .bold()
                }
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
            chart: nil,
            name: "Russian Ruble",
            value: "₽ 61,58",
            hasBottomSeparator: true
        ))
        CurrencyCell(model: .init(
            badge: CurrencyBadge.Model(text: "RUB", textColor: .label, backgroundColor: .systemFill),
            chart: CurrencyMiniChart.Model(color: .green, items: [
                .init(date: .now.addingTimeInterval(-(60*60*24*6)), price: 61.775022),
                .init(date: .now.addingTimeInterval(-(60*60*24*5)), price: 61.32499),
                .init(date: .now.addingTimeInterval(-(60*60*24*4)), price: 61.525038),
                .init(date: .now.addingTimeInterval(-(60*60*24*3)), price: 61.525038),
                .init(date: .now.addingTimeInterval(-(60*60*24*2)), price: 61.525038),
                .init(date: .now.addingTimeInterval(-(60*60*24*1)), price: 61.347969),
                .init(date: .now.addingTimeInterval(-(60*60*24)), price: 61.542459),
            ]),
            name: "Russian Ruble",
            value: "₽ 61,58",
            hasBottomSeparator: true
        ))
    }
}
