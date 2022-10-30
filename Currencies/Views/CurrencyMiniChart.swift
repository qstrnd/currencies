//
//  CurrencyMiniChart.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import SwiftUI
import Charts

struct CurrencyMiniChart: View {
    struct Model {
        let color: Color
        let items: [ChartItem]

        var average: Double {
            items.reduce(0) { sum, item in
                sum + item.price
            } / Double(items.count)
        }
    }

    struct ChartItem: Identifiable {
        let date: Date
        let price: Double

        var id: Date {
            date
        }
    }

    @State var model: Model

    var body: some View {
        Chart(model.items) {
            RuleMark(
                xStart: .value("Start", model.items.first!.date),
                xEnd: .value("End", model.items.last!.date),
                y: .value("Average", model.average)
            )
            .lineStyle(.init(dash: [4]))
            .foregroundStyle(model.color)


            LineMark(
                x: .value("Date", $0.date),
                y: .value("Price", $0.price)
            )
            .lineStyle(.init(lineWidth: 1))
            .foregroundStyle(model.color)

            AreaMark(
                x: .value("Date", $0.date),
                y: .value("Price", $0.price)
            )
            .foregroundStyle(
                Gradient (
                    colors: [
                        model.color.opacity(0.3),
                        model.color.opacity(0.1),
                        model.color.opacity(0)
                    ]
                )
            )
        }
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)

    }

}

struct CurrencyMiniChart_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyMiniChart(model: .init(color: .red, items: [
            .init(date: .now.addingTimeInterval(-(60*60*24*4)), price: 62.4),
            .init(date: .now.addingTimeInterval(-(60*60*24*3)), price: 61.8),
            .init(date: .now.addingTimeInterval(-(60*60*24*2)), price: 62.0),
            .init(date: .now.addingTimeInterval(-(60*60*24*1)), price: 61.3),
            .init(date: .now, price: 61.4)
        ]))
    }
}
