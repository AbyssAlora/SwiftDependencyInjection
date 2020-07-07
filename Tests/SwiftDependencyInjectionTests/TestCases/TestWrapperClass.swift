//
// Created by Abyss Alora on 07/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

class TestWrapperClass {
    @Inject
    var firstInjectedClass: TestInjectClass!
}