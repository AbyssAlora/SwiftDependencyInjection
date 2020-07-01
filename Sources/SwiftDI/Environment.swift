//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

class Environment {
    var objects: [String: Injectable] = [:]
    static var `default` = Environment()


//    func define<T: Injectable>(inject type: T.Type, forKey: String? = nil, properties: [PropertyProtocol] = []) -> Environment {
//        let object = T.init()
//
//        for property in properties {
//            property.set(for: object)
//        }
//
//        self.objects[forKey ?? String(describing: T.self)] = object
//
//        return self
//    }

    func define<T: Injectable>(inject type: T.Type, forKey: String? = nil) -> Environment {
        self.objects[forKey ?? String(describing: T.self)] = T.init()
        return self
    }

    func define<T: Injectable>(inject type: T.Type, forKey: String? = nil, factory: @escaping (Environment)->(T)) -> Environment {
        self.objects[forKey ?? String(describing: T.self)] = factory(self)
        return self
    }

    func define<T: Injectable>(inject type: T.Type, forKey: String? = nil, factory: @escaping ()->(T)) -> Environment {
        self.objects[forKey ?? String(describing: T.self)] = factory()
        return self
    }

    func getObject<T: Injectable>(of type: T.Type, forKey: String? = nil) -> T? {
        if let forKey = forKey {
            return self.objects[forKey] as? T
        }
        return self.objects[String(describing: T.self)] as? T
    }
}

