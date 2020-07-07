import XCTest
import class Foundation.Bundle
@testable import SwiftDependencyInjection
import Foundation

final class SwiftDependencyInjectionTests: XCTestCase {

    func testInjectionTransient() {
        Injector.env.reset()

        Injector.env.build {
            PointModule()
            InjectClassPrototypeModule()
        }

        let injectedWrapperTransient = TestWrapperClass()
        XCTAssertEqual(injectedWrapperTransient.firstInjectedClass, injectedWrapperTransient.firstInjectedClass)
    }

    func testInjectionPersistent() {
        Injector.env.reset()

        Injector.env.build {
            PointModule()
            InjectClassSingletonModule()
        }

        let injectedWrapperPersistent1 = TestWrapperClass()
        let injectedWrapperPersistent2 = TestWrapperClass()
        XCTAssertEqual(injectedWrapperPersistent1.firstInjectedClass, injectedWrapperPersistent2.firstInjectedClass)
    }

    func testInjectionValueTransient() {
        Injector.env.reset()

        Injector.env.build {
            PointModule()
            InjectClassPrototypeModule()
        }

        let point = TestPoint()
        let injectedWrapper = TestWrapperClass()

        XCTAssertEqual(point.x, injectedWrapper.firstInjectedClass.point.x)
        XCTAssertEqual(point.y, injectedWrapper.firstInjectedClass.point.y)
    }

    func testInjectionValuePersistent() {
        Injector.env.reset()

        Injector.env.build {
            PointModule()
            InjectClassSingletonModule()
        }

        let point = TestPoint()
        let injectedWrapper = TestWrapperClass()

        XCTAssertEqual(point.x, injectedWrapper.firstInjectedClass.point.x)
        XCTAssertEqual(point.y, injectedWrapper.firstInjectedClass.point.y)
    }

    func testInjectionValuePersistentUpdate() {
        Injector.env.reset()

        Injector.env.build {
            PointModule()
            InjectClassSingletonModule()
        }

        let point = TestPoint(x: 11, y: 10)
        let injectedWrapper = TestWrapperClass()

        injectedWrapper.firstInjectedClass.point.x = 11
        injectedWrapper.firstInjectedClass.point.y = 10

        XCTAssertEqual(point.x, injectedWrapper.firstInjectedClass.point.x)
        XCTAssertEqual(point.y, injectedWrapper.firstInjectedClass.point.y)

        let injectedWrapper2 = TestWrapperClass()

        XCTAssertEqual(point.x, injectedWrapper2.firstInjectedClass.point.x)
        XCTAssertEqual(point.y, injectedWrapper2.firstInjectedClass.point.y)
    }

    static var allTests = [
        ("testInjectionTransient", testInjectionTransient),
        ("testInjectionPersistent", testInjectionPersistent),
        ("testInjectionValueTransient", testInjectionValueTransient),
        ("testInjectionValuePersistent", testInjectionValuePersistent),
    ]
}
