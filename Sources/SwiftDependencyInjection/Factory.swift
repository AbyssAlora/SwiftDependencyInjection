//
// Created by Abyss Alora on 06/07/2020.
//

import Foundation

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



