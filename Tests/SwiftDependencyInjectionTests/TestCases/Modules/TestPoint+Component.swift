//
// Created by Abyss Alora on 07/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

class PointModule: Injector.Component {

    @Prototype(name: "x")
    var x = Factory<Int> { env in
        5
    }

    @Singleton(name: "y")
    var y = Factory { env in
        10
    }

    @Prototype
    var componentPoint = Factory<Point> { env in
        let (x, y) = (
                env.resolve(Int.self, name: "x")!, 
                env.resolve(Int.self, name: "y")!
        )
        return TestPoint(x: x, y: y)
    }
}