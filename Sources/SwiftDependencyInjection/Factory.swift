//
// Created by Abyss Alora on 06/07/2020.
//

import Foundation

public class Factory<T>: AnyFactory {

    public var name: String = String(describing: T.self)

    var factory: (Injector) -> T

    public init(_ create: @escaping (Injector) -> T) {
        self.factory = create
    }

    public func create() -> Any! {
        self.factory(self.environment)
    }

    public func singleton() -> AnyFactory {
        let singleton = SingletonFactory<T>(self.factory)
        singleton.name = self.name
        return singleton
    }

    public func prototype() -> AnyFactory {
        self
    }
}



