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

    private var environment = Injector.env

    var wrappedValue: T? {
        get {
            value
        }
    }

    init(name: String? = nil, wrappedValue: T? = nil) {
        let name = name ?? String(describing: T.self)
        self.value = self.environment.getObject(of: T.self, name: name)
    }

    convenience init(wrappedValue: T? = nil) {
        self.init(name: nil, wrappedValue: wrappedValue)
    }
}
