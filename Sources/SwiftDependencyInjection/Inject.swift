//
//  Inject.swift
//  CHTTPParser
//
//  Created by Abyss Alora on 10/08/2019.
//

import Foundation

//Property wrapper for Injectable classes
@propertyWrapper
public class Inject<T> {
    private(set) var value: T?

    private var environment = Injector.env

    public var wrappedValue: T? {
        get {
            value
        }
        set {
            self.value = newValue
        }
    }

    init(name: String? = nil, wrappedValue: T? = nil) {
        let name = name ?? String(describing: T.self)
        self.value = self.environment.resolve(T.self, name: name)
    }

    convenience public init(wrappedValue: T? = nil) {
        self.init(name: nil, wrappedValue: wrappedValue)
    }
}
