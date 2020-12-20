//
//  Inject.swift
//  CHTTPParser
//
//  Created by Abyss Alora on 10/08/2019.
//

import Foundation

//Property wrapper for Injectable classes
@propertyWrapper
class Inject<T> {
    private(set) var value: T?

    private var name: String
    private var environment = Injector.env

    var wrappedValue: T? {
        get {
            if let value = self.value {
                return value
            }
            self.value = self.environment.resolve(T.self, name: self.name)
            return self.value
        }
        set {
            self.value = newValue
        }
    }

    init(name: String? = nil, wrappedValue: T? = nil) {
        self.name = name ?? String(describing: T.self)
        self.value = self.environment.resolve(T.self, name: self.name)
    }

    convenience init(wrappedValue: T? = nil) {
        self.init(name: nil, wrappedValue: wrappedValue)
    }
}

