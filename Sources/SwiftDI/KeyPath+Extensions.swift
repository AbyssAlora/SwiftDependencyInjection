//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

extension KeyPath where Root: NSObject {
    var toString: String {
        NSExpression(forKeyPath: self).keyPath
    }
}
