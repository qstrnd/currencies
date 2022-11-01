//
//  Resolved.swift
//  Currencies
//
//  Created by Andrey Yakovlev on 01.11.2022.
//

import Foundation

/// property wrapper to automatically inject dependencies through initialiser
/// ```
/// @Resolved myDependency: DependencyProtocol
/// ```
@propertyWrapper
struct Resolved<T> {
    var wrappedValue: T

    init(name: DependencyResolver.Names? = nil) {
        self.wrappedValue = DependencyResolver.shared.resolve(T.self, name: name)
    }
}
