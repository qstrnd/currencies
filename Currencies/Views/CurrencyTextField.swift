//
//  CurrencyTextField.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 30.10.2022.
//

import SwiftUI

struct CurrencyTextField: View {
    struct Model {
        let badge: CurrencyBadge.Model
        let placeholderText: String
        var text: String
    }

    @State var model: Model

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                CurrencyBadge(model: model.badge)
                Spacer()
                TextField("", text: $model.text)
                    .multilineTextAlignment(.trailing)
                    .placeholder(when: model.text.isEmpty) {
                        HStack {
                            Spacer()
                            Text(model.placeholderText)
                                .foregroundColor(.placeholderText)
                                .bold()
                        }
                    }

            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.tertiarySystemFill)
        }
    }
}

struct CurrencyTextField_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyTextField(model: .init(
            badge: .init(text: "USD", textColor: .label, backgroundColor: .systemFill),
            placeholderText: "1",
            text: ""
        ))
    }
}
