//
// Created by Abyss Alora on 06/07/2020.
//

import Foundation

@propertyWrapper
class Prototype {
    private var value: AnyFactory

    var wrappedValue: AnyFactory {
        get {
            value.prototype()
        }
    }

    init(wrappedValue: AnyFactory, name: String? = nil) {
        self.value = wrappedValue
        if let name = name {
            self.value.name = name
        }
    }

    convenience init(wrappedValue: AnyFactory) {
        self.init(wrappedValue: wrappedValue, name: nil)
    }
}