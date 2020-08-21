# SwiftDependencyInjection

Let's share some ideas behind Dependency injection in Swift. 
This is the small pure Swift library. 

## Usage
Usege is pretty easy, you just have to defined your `Injector` environment. Just for examples let's
work with these classes and protocols:

Animal, Mouse and Cat (where you can see `@Inject var` what's just for example with auto injection) :
```swift
protocol Animal {
    var name: String? { get }
    var eats: Animal! { get }
}

extension Animal {
    var eats: Animal! { nil }
}

class Cat: Animal {
    let name: String?

    @Inject(name: "someMouse") 
    var eats: Animal!

    init(name: String?) {
        self.name = name
    }
}

class Mouse: Animal {
    let name: String? = "some mouse"
}
```

Person etc.:
```swift
protocol Person {
    func playWith() -> Animal
}

class PetOwner: Person {
    let pet: Animal

    init(pet: Animal) {
        self.pet = pet
    }

    func playWith() -> Animal {
        pet
    }
}
```


### Create and build environment
There are three possible methods to define environment. In each example we'll work with few classes.

#### Environment with auto registration modules

Auto registration is based on reflection and its called once. First of all you need to create some
`Injector.Component`. We can define multiple modules and build Injector environment.

```swift
class AnimalComponent: Injector.Component {
    @Prototype(name: "someMouse")
    var someMouse = Factory<Animal> { env in
        Mouse()
    }

    @Singleton(name: "Mimi")
    var catMimi = Factory<Animal> { env in
        Cat(name: "Mimi")
    }
}
```

and for Person: 
```swift
class PersonComponent: Injector.Component {
    @Singleton
    var mimiOwner = Factory<Person> { env in
        PetOwner(pet: env.resolve(Animal.self, name: "Mimi")!)
    }
}
```

Now we need build our environment (for example in `AppDelegate`):

```swift
Injector.build {
    AnimalComponent()
    PersonComponent()
}
```

or with single component:

```swift
AnimalComponent().register()
```



#### Environment with manual registration modules

If we don't want to use auto registration, we can register our modules manually:
```swift
class AnimalComponent: Injector.Component {

    static func someMouse() -> Animal {
        Mouse()
    }

    static func catMimi() -> Animal {
        Cat(name: "Mimi")
    }

    func register() {
        self.inject(name: "someMouse", factory: Self.someMouse)
        self.inject(name: "Mimi", singleton: Self.catMimi())
    }
}
```

#### Configure Environment directly

As well as you can configure your environment directly:

```swift
Injector.env
    .define(...)
    .define(...)
    // etc
```

### Usage of object from environment

When you have defined environment, then you can `@Inject` objects. First example was shown in `Cat` class:
```swift
class Cat: Animal {
    let name: String?

    @Inject(name: "someMouse") 
    var eats: Animal!

    init(name: String?) {
        self.name = name
    }
}
```
where `eats` is injected directly from `Injector.env`. If you want to resolve objects (e.g. in your AppDelegate) 
yourselves just do:
```swift
let petOwner = Injector.resolve(Person.self)
let cat = Injector.resolve(Animal.self, name: "Mimi")
```

and you can access them like this:
```swift
petOwner?.playWith().eats.name
```


### Inected objects states

There are two possible states for injected objects:
- `@Singleton`  always returns same object
- `@Prototype`  return same object until self is alive 


Contributing
------

Contribution is welcome.

Contributors: [@drago19sk](https://github.com/drago19sk) [@SlaveMast3r](https://github.com/SlaveMast3r)

Licence
------

MIT