//
//  LoggerTests.swift
//
//
//  Created by Marcel on 23.11.2023.
//

import XCTest
@testable import Logger

final class LoggerTests: XCTestCase {
    // Test the default log level
    func testDefaultLogLevel() {
        XCTAssertEqual(Logger.logLevel, Logger.LogLevel.error, "Default log level should be error")
    }

    // Test setting a different log level
    func testSetLogLevel() {
        Logger.logLevel = .info
        XCTAssertEqual(Logger.logLevel, Logger.LogLevel.info, "Log level should be set to info")
    }
}
