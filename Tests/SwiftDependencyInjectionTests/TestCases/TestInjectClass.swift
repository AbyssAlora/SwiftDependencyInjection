//
// Created by Abyss Alora on 07/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

class TestInjectClass: NSObject {
    @Inject var point: Point!
    @Inject(name: "x") var x: Int!
    @Inject(name: "y") var y: Int!
}