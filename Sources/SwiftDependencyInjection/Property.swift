//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

class Property<I: Injectable, T>: PropertyProtocol {

    private var value: T
    private var type: T.Type
    private var keyPath: String

    required init(value: T, for keyPath: KeyPath<I, T>) {
        self.value = value
        self.type = T.self
        self.keyPath = "\(keyPath)"
    }

    required init(value: T, forKey: String) {
        self.value = value
        self.type = T.self
        self.keyPath = forKey
    }

    func set(for: NSObject) {
        `for`.setValue(self.value, forKey: self.keyPath)
    }
}