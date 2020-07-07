//
// Created by Abyss Alora on 07/07/2020.
//

import Foundation
@testable import SwiftDependencyInjection

class TestInjectClass: NSObject {
    @Inject var point: TestPoint!
}