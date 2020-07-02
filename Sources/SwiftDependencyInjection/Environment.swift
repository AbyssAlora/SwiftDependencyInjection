//
// Created by Abyss Alora on 01/07/2020.
//

import Foundation

class Environment {
    var container: [String: Injectable] = [:]
    var state: State = .load

    static var `default` = Environment()

    init(name: String? = nil, state: State = .load) {
        self.state = state
    }

    init(name: String? = nil, state: State = .load, @EnvironmentBuilder _ builder: () -> [String: Injectable]){
        self.state = state
        self.container = builder()
    }

    func define<T: NSObject>(inject type: T.Type, name: String? = nil, properties: [PropertyProtocol] = []) -> Environment {
        let object = T.init()

        for property in properties {
            property.set(for: object)
        }

        self.container[name ?? String(describing: T.self)] = object

        return self
    }

    func define<T: Injectable>(inject type: T.Type, name: String? = nil) -> Environment {
        self.container[name ?? String(describing: T.self)] = T.init()
        return self
    }

    func define<T: Injectable>(inject type: T.Type, name: String? = nil, factory: @escaping (Environment)->(T)) -> Environment {
        self.container[name ?? String(describing: T.self)] = factory(self)
        return self
    }

    func define<T: Injectable>(inject type: T.Type, name: String? = nil, factory: @escaping ()->(T)) -> Environment {
        self.container[name ?? String(describing: T.self)] = factory()
        return self
    }

    func getObject<T: Injectable>(of type: T.Type, name: String? = nil) -> T? {
        if let name = name {
            return self.container[name] as? T
        }
        return self.container[String(describing: T.self)] as? T
    }
}

