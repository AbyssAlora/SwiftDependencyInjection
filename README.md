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
- `.singleton` always return same object from persistent container **(default)**

Usage is easy:
```swift
class UserServices {

    // Transient object
    @Inject(lifeTime: .transient) 
    var anotherTransientService: Service!
    
    // Ephemeral object
    @Inject(lifeTime: .emphemeral) 
    var empehemeralService: Service!
    
    // Persistent object
    @Inject 
    var transientService: Service!

    // Keyed persistent object
    @Inject(lifeTime: .singleton, name: "persistentService") 
    var keyedPersistentService: Service!
}
```

### Set injected object through Environment

Objects are automatically stored in `Environment.default` but you can also make
some configuration:

#### example 1: 
```swift

class Point: Injectable {
    var x: Int = 5
    var y: Int = 10

    required init() { } // it's required for construction
}

let environment = Environment()
        .define(
                inject: Point.self,
                name: "test_point"
        )
```

#### example 2:

```swift
class Point: NSObject {
    var x: Int = 5
    var y: Int = 10

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

let environment = Environment()
        .define(
                inject: TestPoint2.self,
                name: "test_point",
                factory: {
                    TestPoint2(x: 15, y: 25)
                }
        )
```

#### example 3:

```swift
// @objcMembers
class Point: NSObject {
    @objc var x: Int = 5
    @objc var y: Int = 10
}

let environment = Environment()
        .define(
                inject: TestPoint2.self,
                name: "test_point",
                properties: [
                    Property(value: 10, for: \TestPoint.x),
                    Property(value: 20, for: \TestPoint.y)
                ]
        )
```

When you have defined you custom environment assign it to the default:
```swift
Environment.default = environment
```

Contributing
------

Contribution is welcome.

Contributors: [@drago19sk](https://github.com/drago19sk) [@SlaveMast3r](https://github.com/SlaveMast3r)

Licence
------

MIT