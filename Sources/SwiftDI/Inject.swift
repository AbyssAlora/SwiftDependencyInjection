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
    private var lifeTime: ObjectLifeTime = .transient

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
            if let value = InjectPersistentContainer.shared.objects[self.persistentKey] as? T {
                self.value = value
            } else {
                self.value = T.init()
                InjectPersistentContainer.shared.objects[self.persistentKey] = self.value
            }

            return self.value // Logic for persistent container is needed
        }
        set {
            self.value = newValue // we cas assign new value if needed
        }
    }

    init(lifeTime: ObjectLifeTime = .transient, persistentKey: String? = nil, wrappedValue: T? = nil) {
        self.lifeTime = lifeTime
        if let persistentKey = persistentKey {
            self.persistentKey = persistentKey
        } else {
            self.persistentKey = String(describing: Self.self)
        }

        if let wrappedValue = wrappedValue {
            self.wrappedValue = wrappedValue
        }

        print(self.persistentKey)
    }

    convenience init(wrappedValue: T? = nil) {
        self.init(lifeTime: .transient, persistentKey: nil, wrappedValue: wrappedValue)
    }

}
