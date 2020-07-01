import XCTest
import class Foundation.Bundle
@testable import SwiftDI
import Foundation

class TestPoint: NSObject, Injectable {
    var x: Int = 5
    var y: Int = 10

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    required override init() { }
}

class TestInjectClass: NSObject, Injectable {
    @Inject var point: TestPoint!
    required override init() { }
}

class TestWrapperClassEphemeral {
    @Inject(lifeTime: .ephemeral)
    var firstInjectedClass: TestInjectClass!
}

class TestWrapperClassTransient {
    @Inject(lifeTime: .persistent)
    var firstInjectedClass: TestInjectClass!
}

//let environment = Environment()
//        .define(
//                inject: TestPoint.self,
//                forKey: "test_point",
//                properties: [
//                    Property(value: 10, for: \TestPoint.x),
//                    Property(value: 20, for: \TestPoint.y)
//                ]
//        )

let environment2 = Environment()
        .define(
                inject: TestPoint.self,
                forKey: "test_point",
                factory: {
                    TestPoint(x: 15, y: 25)
                }
        )

class TestWrapperClassPersistent {
    @Inject
    var firstInjectedClass: TestInjectClass!
}

class TestEnvironment {
    @Inject(persistentKey: "test_point")
    var point: TestPoint!
}

final class SwiftDITests: XCTestCase {

    func testInjectionEphemeral() {
        let injectedWrapperEphemeral = TestWrapperClassEphemeral()
        XCTAssertNotEqual(injectedWrapperEphemeral.firstInjectedClass, injectedWrapperEphemeral.firstInjectedClass)
    }

    func testInjectionTransient() {
        let injectedWrapperTransient = TestWrapperClassTransient()
        XCTAssertEqual(injectedWrapperTransient.firstInjectedClass, injectedWrapperTransient.firstInjectedClass)
    }

    func testInjectionPersistent() {
        let injectedWrapperPersistent1 = TestWrapperClassPersistent()
        let injectedWrapperPersistent2 = TestWrapperClassPersistent()
        XCTAssertEqual(injectedWrapperPersistent1.firstInjectedClass, injectedWrapperPersistent2.firstInjectedClass)
    }

    func testInjectionValueEphemeral() {
        let point = TestPoint()
        let injectedWrapper = TestWrapperClassEphemeral()

        XCTAssertEqual(point.x, injectedWrapper.firstInjectedClass.point.x)
        XCTAssertEqual(point.y, injectedWrapper.firstInjectedClass.point.y)
    }

    func testInjectionValueTransient() {
        let point = TestPoint()
        let injectedWrapper = TestWrapperClassTransient()

        XCTAssertEqual(point.x, injectedWrapper.firstInjectedClass.point.x)
        XCTAssertEqual(point.y, injectedWrapper.firstInjectedClass.point.y)
    }

    func testInjectionValuePersistent() {
        let point = TestPoint()
        let injectedWrapper = TestWrapperClassPersistent()

        XCTAssertEqual(point.x, injectedWrapper.firstInjectedClass.point.x)
        XCTAssertEqual(point.y, injectedWrapper.firstInjectedClass.point.y)
    }


//    func testInjectionEnvironment() {
//        Environment.default = environment
//
//        let testEnvironment = TestEnvironment()
//
//        XCTAssertEqual(10, testEnvironment.point.x)
//        XCTAssertEqual(20, testEnvironment.point.y)
//    }

    func testInjectionEnvironment2() {
        Environment.default = environment2

        let testEnvironment = TestEnvironment()

        XCTAssertEqual(15, testEnvironment.point.x)
        XCTAssertEqual(25, testEnvironment.point.y)
    }

    static var allTests = [
        ("testInjectionEphemeral", testInjectionEphemeral),
        ("testInjectionTransient", testInjectionTransient),
        ("testInjectionPersistent", testInjectionPersistent),
        ("testInjectionValueEphemeral", testInjectionValueEphemeral),
        ("testInjectionValueTransient", testInjectionValueTransient),
        ("testInjectionValuePersistent", testInjectionValuePersistent),
//        ("testInjectionEnvironment", testInjectionEnvironment),
        ("testInjectionEnvironment2", testInjectionEnvironment2),
    ]
}
