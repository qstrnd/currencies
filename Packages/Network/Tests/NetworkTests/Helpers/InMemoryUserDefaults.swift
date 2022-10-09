//
//  InMemoryUserDefaults.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import Foundation

final class InMemoryUserDefaults: UserDefaults {
    private var values = [String: Any]()

    override func object(forKey defaultName: String) -> Any? {
        values[defaultName]
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        values[defaultName] = value
    }
}
