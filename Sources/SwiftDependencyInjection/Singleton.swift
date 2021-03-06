//
// Created by Abyss Alora on 06/07/2020.
//

import Foundation

@propertyWrapper
public class Singleton {
    private var value: AnyFactory

    public var wrappedValue: AnyFactory  {
        get {
            value.singleton()
        }
    }

    public init(wrappedValue: AnyFactory, name: String? = nil) {
        self.value = wrappedValue
        if let name = name {
            self.value.name = name
        }
    }

    convenience public init(wrappedValue: AnyFactory) {
        self.init(wrappedValue: wrappedValue, name: nil)
    }
}

