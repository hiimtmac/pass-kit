import XCTest

import GeneratorTests

var tests = [XCTestCaseEntry]()
tests += PassKitTests.allTests()
XCTMain(tests)
