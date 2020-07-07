//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

final class Injector {
    private var container: [String: AnyFactory] = [:]

    static let env = Injector()

    @discardableResult
    func define(name: String?, factory: AnyFactory) -> Injector {
        let name = name ?? factory.name
        self.has(name: name)
        self.container[name] = factory
        return self
    }

    @discardableResult
    func define<T>(name: String? = nil, singleton: T) -> Injector {
        let name = name ?? String(describing: T.self)
        self.has(name: name)
//        self.container[name ?? String(describing: T.self)] = Factory(singleton: singleton)
        return self
    }

    @discardableResult
    func define<T>(name: String? = nil, factory: @escaping (Injector)->(T)) -> Injector {
        let name = name ?? String(describing: T.self)
        self.has(name: name)
//        self.container[name ?? String(describing: T.self)] = Factory {
//            factory(self)
//        }
        return self
    }

    @discardableResult
    func define<T>(name: String? = nil, factory: @escaping ()->(T)) -> Injector {
        let name = name ?? String(describing: T.self)
        self.has(name: name)
//        self.container[name ?? String(describing: T.self)] = Factory(create: factory)
        return self
    }

    func getObject<T>(of type: T.Type, name: String? = nil) -> T? {
        self.container[name ?? String(describing: T.self)]?.create() as? T
    }

    @discardableResult
    private func has(name: String) -> Bool {
        if container[name] != nil {
            #warning("Duplicate definition in injector!")
        }
        return false
    }

    func build(@Builder _ builder: () -> (Void)) {
        builder()
    }

    func reset() {
        self.container.removeAll()
    }
}
