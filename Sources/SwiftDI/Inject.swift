//
//  Inject.swift
//  CHTTPParser
//
//  Created by Abyss Alora on 10/08/2019.
//

import Foundation

//Property wrapper for Injectable classes
@propertyWrapper
class Inject<T: Injectable> {
    private(set) var value: T?
    private var lifeTime: ObjectLifeTime = .persistent

    private var persistentKey: String
    
    var wrappedValue: T? {
        get {
            if self.lifeTime == .transient {
                // If actual value is nil, then create new and return created object
                guard let value = self.value else {
                    self.value = T.init()
                    return self.value
                }
                // just return value if created
                return value
            }

            if self.lifeTime == .ephemeral {
                return T.init()
            }

            // Lets construct persistent object
            guard let value = Environment.default.getObject(of: T.self, forKey: self.persistentKey) else {
                Environment.default.define(inject: T.self, forKey: self.persistentKey)
                return Environment.default.getObject(of: T.self, forKey: self.persistentKey)
            }
            return value // Logic for persistent container is needed
        }
        set {
            self.value = newValue // we cas assign new value if needed
        }
    }

    init(lifeTime: ObjectLifeTime = .persistent, persistentKey: String? = nil, wrappedValue: T? = nil) {
        self.lifeTime = lifeTime
        if let persistentKey = persistentKey {
            self.persistentKey = persistentKey
        } else {
            self.persistentKey = String(describing: T.self)
        }

        if let wrappedValue = wrappedValue {
            self.wrappedValue = wrappedValue
        }
    }

    convenience init(wrappedValue: T? = nil) {
        self.init(lifeTime: .persistent, persistentKey: nil, wrappedValue: wrappedValue)
    }

}
