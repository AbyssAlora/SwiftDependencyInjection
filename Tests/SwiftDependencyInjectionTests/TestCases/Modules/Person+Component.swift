//
// Created by Abyss Alora on 11/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

class PersonComponent: Injector.Component {
    @Singleton
    var mimiOwner = Factory<Person> { env in
        PetOwner(pet: env.resolve(Animal.self, name: "Mimi")!)
    }
}