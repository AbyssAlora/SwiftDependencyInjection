//
// Created by Abyss Alora on 11/07/2020.
//

import Foundation

public protocol AnyFactory {
    func create() -> Any!
    var name: String { get set }
    var environment: Injector { get }
    func singleton() -> AnyFactory
    func prototype() -> AnyFactory
}

public extension AnyFactory {
    var environment: Injector {
        Injector.env
    }
}