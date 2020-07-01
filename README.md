# SwiftDI

Easy Dependency injection in Swift. This is the pure Swift library.  

## Usage
Usege is pretty easy, you just have to defined your object as `Injectable` 
where is required `init()` for object construction. After that, you can **Inject**
your object wherever you want. 

### Create an Injectable object
Just extend from `Injectable` and do whatever you want.

```swift
class Network: Injectable {
    let connector: Connector = Connector() // some attributes
    required init() {
        //  
    }
}

class Service: Injectable {
    @Inject var network: Network!
    required init() {
        //  
    }
}
```

### How to use Injected objects
When you have injected object you can use those as usual.

```swift
class UserServices {
    @Inject
    var service: Service!
}

let userServices = UserServices()

// lets obtain connector if needed
let connector = userServices.service.network.connector
```

### Inected objects states

There are three possible states for injected objects:
- `.ephemeral`  always return a new object
- `.transient`  return same object until self is alive 
- `.persistent` always return same object from persistent container **(default)**

Usage is easy:
```swift
class UserServices {

    // Transient object
    @Inject(lifeTime: .transient) var anotherTransientService: Service!
    
    // Ephemeral object
    @Inject(lifeTime: .emphemeral) var empehemeralService: Service!
    
    // Persistent object
    @Inject var transientService: Service!

    // Keyed persistent object
    @Inject(lifeTime: .persistent, persistentKey: "persistentService") 
    var keyedPersistentService: Service!
}
```

### Set injected object through Environment

Objects are automatically stored in `Environment.default` but you can also make
some configuration:

```swift
let _ = Environment.default
            .define(inject: Network.self, forKey: "network")
            .define(inject: Service.self)
```

Contributing
------

Contribution is welcome.

Contributors: [@drago19sk](https://github.com/drago19sk) [@SlaveMast3r](https://github.com/SlaveMast3r)

Licence
------

MIT