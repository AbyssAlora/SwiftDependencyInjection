//
// Created by Abyss Alora on 02/07/2020.
//

import Foundation

extension Injector {
    @_functionBuilder
    struct Builder {
        static func buildBlock(_ components: Component...) -> Void {
            for component in components {
                component.register()
            }
        }
    }
}