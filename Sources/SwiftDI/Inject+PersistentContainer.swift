//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

class InjectPersistentContainer {
    var objects: [String: Injectable] = [:]
    static var shared = InjectPersistentContainer()
}