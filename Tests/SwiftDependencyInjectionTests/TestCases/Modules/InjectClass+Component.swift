//
// Created by Abyss Alora on 07/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

class InjectClassSingletonModule: Injector.Component {
    @Singleton
    var componentTestInjectClass = Factory { env in
        TestInjectClass()
    }
}

class InjectClassPrototypeModule: Injector.Component {
    @Prototype
    var componentTestInjectClass = Factory { env in
        TestInjectClass()
    }
}