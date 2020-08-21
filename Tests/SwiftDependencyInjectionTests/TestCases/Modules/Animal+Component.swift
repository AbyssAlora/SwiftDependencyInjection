//
// Created by Abyss Alora on 11/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

class AnimalComponent: Injector.Component {
    @Prototype(name: "someMouse")
    var someMose = Factory<Animal> { env in
        Mouse()
    }

    @Singleton(name: "Mimi")
    var catMimi = Factory<Animal> { env in
        Cat(name: "Mimi")
    }
}