//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

final public class Injector {
    private var container = [String: AnyFactory]()

    public static let env = Injector()

    @discardableResult
    public func define(name: String?, factory: AnyFactory) -> Injector {
        let name = name ?? factory.name
        self.has(name: name)
        self.container[name] = factory
        return self
    }

    @discardableResult
    public func define<T>(name: String? = nil, singleton: T) -> Injector {
        self.define(name: name, factory: SingletonFactory { _ in singleton} )
        return self
    }

    @discardableResult
    public func define<T>(name: String? = nil, factory: @escaping (Injector)->(T)) -> Injector {
        self.define(name: name, factory: Factory(factory))
        return self
    }

    @discardableResult
    public func define<T>(name: String? = nil, factory: @escaping ()->(T)) -> Injector {
        self.define(name: name, factory: Factory { _ in factory()})
        return self
    }

    public func resolve<T>(_ type: T.Type, name: String? = nil) -> T? {
        self.container[name ?? String(describing: T.self)]?.create() as? T
    }

    public static func resolve<T>(_ type: T.Type, name: String? = nil) -> T? {
        Self.env.resolve(type, name: name)
    }

    @discardableResult
    private func has(name: String) -> Bool {
        if container[name] != nil {
            #warning("Duplicate definition in injector!")
        }
        return false
    }

    public func build(@Builder _ builder: () -> (Void)) {
        builder()
    }

    public func reset() {
        self.container.removeAll()
    }
}
