//
// Created by Abyss Alora on 07/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

class PointModule: Injector.Component {

    @Prototype(name: "x")
    var x = Factory { env in
        5
    }

    @Singleton(name: "y")
    var y = Factory { env in
        10
    }

    @Prototype
    var componentPoint = Factory<TestPoint> { env in
        let (x, y) = (
                env.getObject(of: Int.self, name: "x"), 
                env.getObject(of: Int.self, name: "y")
        )
        return TestPoint(x: x!, y: y!)
    }
}