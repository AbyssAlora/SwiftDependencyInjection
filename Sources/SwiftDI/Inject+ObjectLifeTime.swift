//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

extension Inject {
    enum ObjectLifeTime {
        case ephemeral // always return a new object
        case transient // return same object until self is alive
        case persistent // always return same object from persistent container
    }
}