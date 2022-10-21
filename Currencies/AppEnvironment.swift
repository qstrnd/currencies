//
//  AppEnvironment.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 21.10.2022.
//

import Foundation

final class AppEnvironment {

    // MARK: Internat

    static let current = AppEnvironment()

    var fixerAPIKey: String {
        config["FIXER_API_KEY"] as! String
    }

    var appName: String {
        config["CFBundleName"] as! String
    }

    var appVersion: String {
        config["CFBundleShortVersionString"] as! String
    }

    var buildNumber: String {
        config["CFBundleVersion"] as! String
    }

    // MARK: Private

    private let config: [String: Any]

    private init() {
        guard let infoUrl = Bundle.main.url(forResource: "Info", withExtension: "plist") else {
            fatalError("No info.plist file found")
        }

        do {
            let infoPlistData = try Data(contentsOf: infoUrl)
            guard let infoDictionary = try PropertyListSerialization.propertyList(from: infoPlistData, format: nil) as? [String: Any] else {
                fatalError("Cannot decode info plist")
            }

            config = infoDictionary
        } catch {
            fatalError("Cannot decode info plist. Error: \(error)")
        }

        // Check keys not missing
        
        _ = fixerAPIKey
        _ = appName
        _ = appVersion
        _ = buildNumber
    }

}
