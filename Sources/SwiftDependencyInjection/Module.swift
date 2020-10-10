//
// Created by Abyss Alora on 06/07/2020.
//

import Foundation

public protocol Module {
    func inject(name: String?, factory: AnyFactory)
    func inject<T>(name: String?, singleton: T)
    func inject<T>(name: String?, factory: @escaping () -> (T))
    func inject<T>(name: String?, factory: @escaping (Injector) -> (T))

    func register()
}

extension Module {
    private var environment: Injector {
        Injector.env
    }

    public func inject(name: String? = nil, factory: AnyFactory) {
        self.environment.define(name: name, factory: factory)
    }

    public func inject<T>(name: String? = nil, singleton: T) {
        self.environment.define(name: name, singleton: singleton)
    }

    public func inject<T>(name: String? = nil, factory: @escaping () -> (T)) {
        self.environment.define(name: name, factory: factory)
    }

    public func inject<T>(name: String?, factory: @escaping (Injector) -> (T)) {
        self.environment.define(name: name, factory: factory)
    }

    func register() {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let value = child.value as? Singleton {
                self.environment.define(name: value.wrappedValue.name, factory: value.wrappedValue)
            } else if let value = child.value as? Prototype {
                self.environment.define(name: value.wrappedValue.name, factory: value.wrappedValue)
            }
        }
    }
}