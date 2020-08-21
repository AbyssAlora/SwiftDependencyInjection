//
// Created by Abyss Alora on 11/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

protocol Animal {
    var name: String? { get }
    var eats: Animal! { get }
}

extension Animal {
    var eats: Animal! { nil }
}

class Cat: Animal {
    let name: String?

    @Inject(name: "someMouse") 
    var eats: Animal!

    init(name: String?) {
        self.name = name
    }
}

class Mouse: Animal {
    let name: String? = "some mouse"
}