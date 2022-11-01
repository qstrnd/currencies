//
//  CurrenciesApp.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import SwiftUI
import Network

@main
struct CurrenciesApp: App {
    let persistenceController = PersistenceController.shared
    @Resolved private var currenciesNetworkService: CurrenciesNetworkService

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    Task {
                        let response = await currenciesNetworkService.getSymbols()
                        switch response {
                        case .success(let symbols):
                            print(symbols)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
        }
    }
}
