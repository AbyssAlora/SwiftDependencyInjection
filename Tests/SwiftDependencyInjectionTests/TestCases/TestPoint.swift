//
// Created by Abyss Alora on 07/07/2020.
//

import Foundation

protocol Point {
    var x: Int { get set }
    var y: Int { get set }
}

class TestPoint: Point {
    var x: Int = 5
    var y: Int = 10

    init(x: Int = 5, y: Int = 10) {
        self.x = x
        self.y = y
    }
}
