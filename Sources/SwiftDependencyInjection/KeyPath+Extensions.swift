//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

extension KeyPath: CustomStringConvertible where Root: NSObject {
    public var description: String {
        NSExpression(forKeyPath: self).keyPath
    }
}
