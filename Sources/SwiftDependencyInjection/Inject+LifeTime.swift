//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

public extension Inject {
    enum LifeTime {
        case ephemeral  // always return a new object
        case `default`  // as defined
    }
}