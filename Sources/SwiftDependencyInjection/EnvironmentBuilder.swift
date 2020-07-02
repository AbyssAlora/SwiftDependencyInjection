//
// Created by Abyss Alora on 02/07/2020.
//

import Foundation

@_functionBuilder
struct EnvironmentBuilder {
    static func buildBlock(_ components: Environment...) -> [String: Injectable] {
        var container: [String: Injectable] = [:]
        for component in components {
            if component.state == .load {
                for (name, object) in component.container {
                    if let _ = container[name] {
                        #warning("Environment: multiple name definitions.")
                    }
                    container[name] = object
                }
            }
        }
        return container
    }
}