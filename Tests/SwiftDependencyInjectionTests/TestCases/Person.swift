//
// Created by Abyss Alora on 11/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

protocol Person {
    func playWith() -> Animal
}

class PetOwner: Person {
    let pet: Animal

    init(pet: Animal) {
        self.pet = pet
    }

    func playWith() -> Animal {
        pet
    }
}