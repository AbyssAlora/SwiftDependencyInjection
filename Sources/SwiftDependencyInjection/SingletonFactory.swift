//
// Created by Abyss Alora on 11/07/2020.
//

import Foundation

public class SingletonFactory<T>: Factory<T> {
    var singleton: T!

    override public func create() -> Any! {
        if let singleton = self.singleton {
            return singleton
        }
        self.singleton = self.factory(self.environment)
        return self.singleton
    }

    override public func prototype() -> AnyFactory {
        let prototype = Factory<T>(self.factory)
        prototype.name = self.name
        return prototype
    }
}