//
//  CurrenciesApp.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import SwiftUI

@main
struct CurrenciesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
