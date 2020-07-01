import XCTest
import class Foundation.Bundle
@testable import SwiftDI
import Foundation

class TestPoint: Injectable {
    let x: Int = 5
    let y: Int = 10
    required init() { }
}

class TestInjectClass: NSObject, Injectable {
    @Inject var point: TestPoint!
    override required init() { }
}

class TestWrapperClassEphemeral {
    @Inject(lifeTime: .ephemeral)
    var firstInjectedClass: TestInjectClass!
}

class TestWrapperClassTransient {
    @Inject
    var firstInjectedClass: TestInjectClass!
}

class TestWrapperClassPersistent {
    @Inject(lifeTime: .persistent)
    var firstInjectedClass: TestInjectClass!
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


    static var allTests = [
        ("testInjectionEphemeral", testInjectionEphemeral),
        ("testInjectionTransient", testInjectionTransient),
        ("testInjectionPersistent", testInjectionPersistent),
        ("testInjectionValueEphemeral", testInjectionValueEphemeral),
        ("testInjectionValueTransient", testInjectionValueTransient),
        ("testInjectionValuePersistent", testInjectionValuePersistent),
    ]
}
