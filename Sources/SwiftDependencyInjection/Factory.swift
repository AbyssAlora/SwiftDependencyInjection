//
// Created by Abyss Alora on 06/07/2020.
//

import Foundation

protocol AnyFactory {
    func create() -> Any!
    var name: String { get set }
    var environment: Injector { get }
    func singleton() -> AnyFactory
    func prototype() -> AnyFactory
}

extension AnyFactory {
    var environment: Injector {
        Injector.env
    }

    func singleton() -> AnyFactory {
        self
    }

    func prototype() -> AnyFactory {
        self
    }
}

class Factory<T>: AnyFactory {

    var name: String = String(describing: T.self)

    var factory: (Injector) -> T

    init(_ create: @escaping (Injector) -> T) {
        self.factory = create
    }

    func create() -> Any! {
        self.factory(self.environment)
    }

    func singleton() -> AnyFactory {
        let singleton = SingletonFactory<T>(self.factory)
        singleton.name = self.name
        return singleton
    }

    func prototype() -> AnyFactory {
        self
    }
}

class SingletonFactory<T>: Factory<T> {
    var singleton: T!

    override func create() -> Any! {
        if let singleton = self.singleton {
            return singleton
        }
        self.singleton = self.factory(self.environment)
        return self.singleton
    }

    override func prototype() -> AnyFactory {
        let prototype = Factory<T>(self.factory)
        prototype.name = self.name
        return prototype
    }
}


